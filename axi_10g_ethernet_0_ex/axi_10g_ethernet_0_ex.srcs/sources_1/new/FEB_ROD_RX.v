`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/27 19:31:18
// Design Name: 
// Module Name: FEB_ROD_RX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// RX data from FEB_ROD bus

// data format:         MSB ------------------------------------------------------------------------------------------------------- LSB
//                      Header                              Type                        Content                                     CRC4
//              8'he8 (comma) / 8'hb4 (data)        command type (4 bits)       command content (48 bits)           calculate 4 bits CRC for (Type + Content)
// one packt = Header + Type + Content + CRC4 = 64 bits

module FEB_ROD_RX(
input           clk_ila,
input           reset,
input           RX_data_i,
input           RX_clk,
output          RX_flag,
output          RX_align,
output  [51:0]  decoded_data_o,
output          decoded_data_valid,
output          decoded_data_CRC
    );
    
// seriral data to 64-bit parallel data    

// LSB of packet input first
// late ----------------------------------------------------------------------------------------> early
// RX_data_buffer[191],RX_data_buffer[190],RX_data_buffer[189]......RX_data_buffer[1],RX_data_buffer[0] ================>> RX_data_buffer[191:0]
(* KEEP="TRUE" *)reg         data_in_r1      = 1'b1;
(* KEEP="TRUE" *)reg         data_in_r2      = 1'b1;          
(* KEEP="TRUE" *)reg [127:0] RX_data_buffer  = 128'h0000000000000000_0000000000000000;          // buffer seriral input, 2 packets = 128bits
always @(posedge RX_clk)                                    
    begin
        if(reset)
            begin
                data_in_r1      <= 1'b1;
                data_in_r2      <= 1'b1;
                RX_data_buffer  <= 128'h0000000000000000_0000000000000000;
            end
        else
            begin
                data_in_r1      <= RX_data_i;
                data_in_r2      <= data_in_r1;   
                RX_data_buffer  <= {data_in_r2,RX_data_buffer[127:1]};              // buffer 1 bit serial data
            end
    end

// data align
// find header in RX_data_buffer[63:56] and RX_data_buffer[127:120]; if found, check header every 64 clk cycle (one packet), or find it every clk cycle
(* KEEP="TRUE" *)reg [5:0]   position    	      = 6'd0;            			 // position of header in packet  
(* KEEP="TRUE" *)reg [5:0]   bit_counter         = 6'd0;                     // bit number of a packet 
(* KEEP="TRUE" *)reg [55:0]  data_aligned        = 56'h00_0000_0000_0000;
(* KEEP="TRUE" *)reg         data_valid_align    = 1'b0;
(* KEEP="TRUE" *)reg         align_flag          = 1'b0;
(* KEEP="TRUE" *)reg [7:0]   header              = 8'h00;          			// header 8'he8 -- comma/null packet, header 8'hb4 -- data packet 
always @(posedge RX_clk)
    begin
        if(reset)
            begin
                position    	    <= 6'd0;    
                bit_counter         <= 6'd0; 
                align_flag          <= 1'b0;
                data_valid_align    <= 1'b0;
                data_aligned 	    <= 56'h00_0000_0000_0000;
                header      	    <= 8'h00;           
            end
        else if((align_flag == 1'b0)&&(((RX_data_buffer[63:56] == 8'he8)||(RX_data_buffer[63:56] == 8'hb4))&&((RX_data_buffer[127:120] == 8'he8)||(RX_data_buffer[127:120] == 8'hb4))))                             // unalign & find header in two continuous packet 
            begin
                position            <= bit_counter;                     // record header position, check header every 64 clk cycles
                data_valid_align    <= 1'b1;
                data_aligned        <= RX_data_buffer[119:64];          // update data & header
                header              <= RX_data_buffer[127:120];
                align_flag          <= 1'b1;                            // packet aligned
                bit_counter         <= bit_counter + 1'b1;
            end
        else if((align_flag == 1'b1)&&(bit_counter == position))        // packet aligned & check header in two continuous packet
            begin
                if(((RX_data_buffer[63:56] == 8'he8)||(RX_data_buffer[63:56] == 8'hb4))&&((RX_data_buffer[127:120] == 8'he8)||(RX_data_buffer[127:120] == 8'hb4)))      // find header in two continuous packet
                    begin
                        position            <= position;                    
                        data_valid_align    <= 1'b1;
                        data_aligned        <= RX_data_buffer[119:64];          // update data & header
                        header              <= RX_data_buffer[127:120];
                        align_flag          <= 1'b1;                                                  
                    end
                else                                                            // check header failed
                    begin
                        position            <= position;                    
                        data_valid_align    <= 1'b0;
                        data_aligned        <= 56'h00_0000_0000_0000;         
                        header              <= 8'h00;   
                        align_flag          <= 1'b0;                            // align again                       
                    end
                bit_counter         <= bit_counter + 1'b1;   
            end
        else                                                                    // hold data
            begin
                position            <= position;                     
                data_valid_align    <= 1'b0;
                data_aligned        <= data_aligned;                           
                header              <= header;
                align_flag          <= align_flag;                              
                bit_counter         <= bit_counter + 1'b1;         
            end
    end  

// align_flag = 1 keeps over 10'h3f2 clk cycles  ==> real_aligned = 1, otherwise unaligned
(* KEEP="TRUE" *)reg         real_aligned = 1'b0;
(* KEEP="TRUE" *)reg [9:0]   hold_counter = 10'h000;
always@(posedge RX_clk)
    if(reset)
        begin
            real_aligned    <= 1'b0;
            hold_counter    <= 10'h000;        
        end
    else                                                           
        begin
            if((align_flag == 1'b1)&&(hold_counter < 10'h3f2))
                begin
                    real_aligned    <= 1'b0;
                    hold_counter    <= hold_counter + 1'b1;
                end
            else if((align_flag == 1'b1)&&(hold_counter == 10'h3f2))    // align_flag keeps 1'b1;
                begin
                    real_aligned    <= 1'b1;
                    hold_counter    <= 10'h3f2;
                end
            else
                begin
                    real_aligned    <= 1'b0;
                    hold_counter    <= 10'h000;          
                end
        end

// pick out data packet, remove null packet
(* KEEP="TRUE" *)reg         data_valid  = 1'b0;
(* KEEP="TRUE" *)reg [55:0]  data_packet = 56'h00_0000_0000_0000;
always@(posedge RX_clk) 
    begin
        if(reset)
            begin
                data_valid  <= 1'b0;
                data_packet <= 56'h00_0000_0000_0000;
            end
        else if((header == 8'hb4)&&(data_valid_align == 1'b1))                  // data packet
            begin
                data_valid  <= 1'b1;
                data_packet <= data_aligned;
            end
        else    
            begin
                data_valid  <= 1'b0;
                data_packet <= 56'h00_0000_0000_0000;
            end
    end

// CRC check (X4 + X + 1)
wire [51:0] data_in_CRC;                                    // data bits of data packet
wire [3:0]  packet_CRC;                                     // CRC bits of data packet
assign  data_in_CRC = data_packet[55:4];
assign  packet_CRC  = data_packet[3:0];

reg [3:0]   CRC4_result     = 4'b0000;                      // CRC calculate result of data packet
reg [3:0]   CRC4_buffer     = 4'b0000;                      // buffer CRC bits of data packet
reg [51:0]  data_buffer_CRC = 52'h0_0000_0000_0000;         // buffer data bits of data packet
reg         CRC_compare     = 1'b0;                         // compare CRC4_result with CRC4_buffer, when CRC_compare = 1'b1;
always@(posedge RX_clk)
    begin
        if(reset)
            begin
                CRC4_result     <= 4'b0000;
                CRC4_buffer     <= 4'b0000;
                data_buffer_CRC <= 52'h0_0000_0000_0000;
                CRC_compare     <= 1'b0;
            end
        else if((data_valid == 1'b1)&&(real_aligned == 1'b1))                           // calculate CRC4_result
            begin
	            CRC4_result[0] <= 1'b0 ^ 1'b1 ^ 1'b1           ^ data_in_CRC[0] ^ data_in_CRC[3] ^ data_in_CRC[4] ^ data_in_CRC[6] ^ data_in_CRC[8] ^ data_in_CRC[9]  ^ data_in_CRC[10] ^ data_in_CRC[11] ^ data_in_CRC[15] ^ data_in_CRC[18] ^ data_in_CRC[19] ^ data_in_CRC[21] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[25] ^ data_in_CRC[26] ^ data_in_CRC[30] ^ data_in_CRC[33] ^ data_in_CRC[34] ^ data_in_CRC[36] ^ data_in_CRC[38] ^ data_in_CRC[39] ^ data_in_CRC[40] ^ data_in_CRC[41] ^ data_in_CRC[45] ^ data_in_CRC[48] ^ data_in_CRC[49] ^ data_in_CRC[51];
                CRC4_result[1] <= 1'b0 ^ 1'b0 ^ 1'b1           ^ data_in_CRC[0] ^ data_in_CRC[1] ^ data_in_CRC[3] ^ data_in_CRC[5] ^ data_in_CRC[6] ^ data_in_CRC[7]  ^ data_in_CRC[8]  ^ data_in_CRC[12] ^ data_in_CRC[15] ^ data_in_CRC[16] ^ data_in_CRC[18] ^ data_in_CRC[20] ^ data_in_CRC[21] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[27] ^ data_in_CRC[30] ^ data_in_CRC[31] ^ data_in_CRC[33] ^ data_in_CRC[35] ^ data_in_CRC[36] ^ data_in_CRC[37] ^ data_in_CRC[38] ^ data_in_CRC[42] ^ data_in_CRC[45] ^ data_in_CRC[46] ^ data_in_CRC[48] ^ data_in_CRC[50] ^ data_in_CRC[51];
                CRC4_result[2] <= 1'b1 ^ 1'b1 ^ data_in_CRC[1] ^ data_in_CRC[2] ^ data_in_CRC[4] ^ data_in_CRC[6] ^ data_in_CRC[7] ^ data_in_CRC[8] ^ data_in_CRC[9]  ^ data_in_CRC[13] ^ data_in_CRC[16] ^ data_in_CRC[17] ^ data_in_CRC[19] ^ data_in_CRC[21] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[28] ^ data_in_CRC[31] ^ data_in_CRC[32] ^ data_in_CRC[34] ^ data_in_CRC[36] ^ data_in_CRC[37] ^ data_in_CRC[38] ^ data_in_CRC[39] ^ data_in_CRC[43] ^ data_in_CRC[46] ^ data_in_CRC[47] ^ data_in_CRC[49] ^ data_in_CRC[51];
                CRC4_result[3] <= 1'b0 ^ 1'b0 ^ data_in_CRC[2] ^ data_in_CRC[3] ^ data_in_CRC[5] ^ data_in_CRC[7] ^ data_in_CRC[8] ^ data_in_CRC[9] ^ data_in_CRC[10] ^ data_in_CRC[14] ^ data_in_CRC[17] ^ data_in_CRC[18] ^ data_in_CRC[20] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[25] ^ data_in_CRC[29] ^ data_in_CRC[32] ^ data_in_CRC[33] ^ data_in_CRC[35] ^ data_in_CRC[37] ^ data_in_CRC[38] ^ data_in_CRC[39] ^ data_in_CRC[40] ^ data_in_CRC[44] ^ data_in_CRC[47] ^ data_in_CRC[48] ^ data_in_CRC[50];	
	            data_buffer_CRC <= data_in_CRC;
                CRC_compare     <= 1'b1;                        // enable CRC check
                CRC4_buffer     <= packet_CRC;
            end
        else
            begin
                CRC4_result     <= 4'b0000;
                data_buffer_CRC <= 52'h0_0000_0000_0000;
                CRC_compare     <= 1'b0;         
                CRC4_buffer     <= 4'b0000;   
            end       
        end

reg         decoded_data_valid_r = 1'b0;                            // decoded_data_valid means packet format is right
reg         decoded_data_CRC_r   = 1'b0;                            // decoded_data_CRC means packet pass the CRC check 
reg [51:0]  decoded_data_r       = 52'h0_0000_0000_0000;            // config data 
always@(posedge RX_clk)
    begin
        if(reset)
            begin
                decoded_data_CRC_r      <= 1'b0;
                decoded_data_r          <= 52'h0_0000_0000_0000;
                decoded_data_valid_r    <= 1'b0;
            end
        else if(CRC_compare == 1'b1)                                            // compare CRC4_result with CRC4_buffer
            begin
                if(CRC4_result == CRC4_buffer)  decoded_data_CRC_r <= 1'b1;
                else    decoded_data_CRC_r <= 1'b0;
                decoded_data_valid_r    <= 1'b1;
                decoded_data_r          <= data_buffer_CRC;
            end
        else
            begin
                decoded_data_CRC_r      <= 1'b0;
                decoded_data_r          <= 52'h0_0000_0000_0000;
                decoded_data_valid_r    <= 1'b0;          
            end       
        end

reg RX_flag_r1  = 1'b0;
reg RX_flag_r2  = 1'b0;
reg RX_flag_r3  = 1'b0;
always@(posedge RX_clk)
    begin
        if(reset)
            begin
                RX_flag_r1  <= 1'b0;
                RX_flag_r2  <= 1'b0;
                RX_flag_r3  <= 1'b0;
            end
        else
            begin
                RX_flag_r1  <= data_valid_align;
                RX_flag_r2  <= RX_flag_r1;   
                RX_flag_r3  <= RX_flag_r2;    
            end
    end


assign  decoded_data_o      = decoded_data_r;
assign  decoded_data_valid  = decoded_data_valid_r;
assign  decoded_data_CRC    = decoded_data_CRC_r;
assign  RX_flag             = RX_flag_r3;
assign  RX_align            = real_aligned;


// ila
//wire [279:0] probe0;
//assign  probe0 = {RX_data_i,RX_clk,data_in_r1,data_in_r2,RX_data_buffer,position,data_aligned,data_valid_align,align_flag,header,real_aligned,hold_counter,CRC4_result,CRC4_buffer,data_buffer_CRC,CRC_compare};
  
//ila_FEB_RX ila_FEB_RX_inst
//(
//.clk(clk_ila),
//.probe0(probe0)
//); 

endmodule
