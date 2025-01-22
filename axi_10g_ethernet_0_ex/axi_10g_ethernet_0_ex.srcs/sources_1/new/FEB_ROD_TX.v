`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/29 14:40:07
// Design Name: 
// Module Name: FEB_ROD_TX
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


// TX data to FEB_ROD bus

// data format:         MSB ------------------------------------------------------------------------------------------------------- LSB
//                      Header                              Type                        Content                                     CRC4
//              8'hca (comma) / 8'hd8 (data)        command type (4 bits)       command content (48 bits)           calculate 4 bits CRC for (Type + Content)
// one packt = Header + Type + Content + CRC4 = 64 bits

module FEB_ROD_TX(
input           reset,
input           TX_clk,
input           write_clk,
input           FEB_select,
input   [51:0]  packet_data_in,         // parallel data input
input           packet_valid,
output          TX_ready,
output          TX_data_o               // serial data output
    );
      
// serialize 64 bits parallel data, LSB output first
(* KEEP="TRUE" *)reg [51:0]  data_in_r       = 52'h0_0000_0000_0000;
(* KEEP="TRUE" *)reg         data_valid_r    = 1'b0;
(* KEEP="TRUE" *)reg [51:0]  data_buffer_CRC = 52'h0_0000_0000_0000;         // buffer data for CRC
(* KEEP="TRUE" *)reg         CRC_enable      = 1'b0;                         // enable CRC
always@(posedge write_clk)
    begin
        if(reset)
            begin
                data_in_r       <= 52'h0_0000_0000_0000;
                data_valid_r    <= 1'b0;
                data_buffer_CRC <= 52'h0_0000_0000_0000;
                CRC_enable      <= 1'b0; 
            end
        else if((data_valid_r == 1'b1)&& FEB_select)            // input data valid
            begin
                data_buffer_CRC <= data_in_r;
                CRC_enable      <= 1'b1;                        // enable CRC calculate when input data valid
                data_in_r       <= packet_data_in;
                data_valid_r    <= packet_valid; 
            end
        else
            begin
                data_buffer_CRC <= 52'h0_0000_0000_0000;
                CRC_enable      <= 1'b0;
                data_in_r       <= packet_data_in;
                data_valid_r    <= packet_valid;             
            end
    end    

// calculate CRC4 (X4 + X + 1), then wtite data packet into fifo
(* KEEP="TRUE" *)reg [3:0]   CRC4                    = 4'b0000;                  // 4-bit CRC result
(* KEEP="TRUE" *)reg [51:0]  data_buffer_fifo        = 52'h0_0000_0000_0000;     // buffer data for serialize
(* KEEP="TRUE" *)reg         fifo_wr_en              = 1'b0;                     // trigger  serialize process      
(* KEEP="TRUE" *)reg         fifo_rd_en              = 1'b0;
wire        fifo_empty,fifo_full;
wire [63:0] fifo_dout,fifo_din;
always@(posedge write_clk)
    begin
        if(reset)
            begin
                CRC4                <= 4'b0000;
                data_buffer_fifo    <= 52'h0_0000_0000_0000;
                fifo_wr_en          <= 1'b0;
            end
        else if(CRC_enable == 1'b1)                             // calculate CRC4
            begin
	            CRC4[0]             <= 1'b0 ^ 1'b1 ^ 1'b1               ^ data_buffer_CRC[0] ^ data_buffer_CRC[3] ^ data_buffer_CRC[4] ^ data_buffer_CRC[6] ^ data_buffer_CRC[8] ^ data_buffer_CRC[9]  ^ data_buffer_CRC[10] ^ data_buffer_CRC[11] ^ data_buffer_CRC[15] ^ data_buffer_CRC[18] ^ data_buffer_CRC[19] ^ data_buffer_CRC[21] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[25] ^ data_buffer_CRC[26] ^ data_buffer_CRC[30] ^ data_buffer_CRC[33] ^ data_buffer_CRC[34] ^ data_buffer_CRC[36] ^ data_buffer_CRC[38] ^ data_buffer_CRC[39] ^ data_buffer_CRC[40] ^ data_buffer_CRC[41] ^ data_buffer_CRC[45] ^ data_buffer_CRC[48] ^ data_buffer_CRC[49] ^ data_buffer_CRC[51];
                CRC4[1]             <= 1'b0 ^ 1'b0 ^ 1'b1               ^ data_buffer_CRC[0] ^ data_buffer_CRC[1] ^ data_buffer_CRC[3] ^ data_buffer_CRC[5] ^ data_buffer_CRC[6] ^ data_buffer_CRC[7]  ^ data_buffer_CRC[8]  ^ data_buffer_CRC[12] ^ data_buffer_CRC[15] ^ data_buffer_CRC[16] ^ data_buffer_CRC[18] ^ data_buffer_CRC[20] ^ data_buffer_CRC[21] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[27] ^ data_buffer_CRC[30] ^ data_buffer_CRC[31] ^ data_buffer_CRC[33] ^ data_buffer_CRC[35] ^ data_buffer_CRC[36] ^ data_buffer_CRC[37] ^ data_buffer_CRC[38] ^ data_buffer_CRC[42] ^ data_buffer_CRC[45] ^ data_buffer_CRC[46] ^ data_buffer_CRC[48] ^ data_buffer_CRC[50] ^ data_buffer_CRC[51];
                CRC4[2]             <= 1'b1 ^ 1'b1 ^ data_buffer_CRC[1] ^ data_buffer_CRC[2] ^ data_buffer_CRC[4] ^ data_buffer_CRC[6] ^ data_buffer_CRC[7] ^ data_buffer_CRC[8] ^ data_buffer_CRC[9]  ^ data_buffer_CRC[13] ^ data_buffer_CRC[16] ^ data_buffer_CRC[17] ^ data_buffer_CRC[19] ^ data_buffer_CRC[21] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[28] ^ data_buffer_CRC[31] ^ data_buffer_CRC[32] ^ data_buffer_CRC[34] ^ data_buffer_CRC[36] ^ data_buffer_CRC[37] ^ data_buffer_CRC[38] ^ data_buffer_CRC[39] ^ data_buffer_CRC[43] ^ data_buffer_CRC[46] ^ data_buffer_CRC[47] ^ data_buffer_CRC[49] ^ data_buffer_CRC[51];
                CRC4[3]             <= 1'b0 ^ 1'b0 ^ data_buffer_CRC[2] ^ data_buffer_CRC[3] ^ data_buffer_CRC[5] ^ data_buffer_CRC[7] ^ data_buffer_CRC[8] ^ data_buffer_CRC[9] ^ data_buffer_CRC[10] ^ data_buffer_CRC[14] ^ data_buffer_CRC[17] ^ data_buffer_CRC[18] ^ data_buffer_CRC[20] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[25] ^ data_buffer_CRC[29] ^ data_buffer_CRC[32] ^ data_buffer_CRC[33] ^ data_buffer_CRC[35] ^ data_buffer_CRC[37] ^ data_buffer_CRC[38] ^ data_buffer_CRC[39] ^ data_buffer_CRC[40] ^ data_buffer_CRC[44] ^ data_buffer_CRC[47] ^ data_buffer_CRC[48] ^ data_buffer_CRC[50];	
	            data_buffer_fifo    <= data_buffer_CRC;
                fifo_wr_en          <= 1'b1;                    // fifo write enable
            end
        else
            begin
                CRC4                <= 4'b0000;
                data_buffer_fifo    <= 52'h0_0000_0000_0000;
                fifo_wr_en          <= 1'b0;            
            end       
        end

assign  fifo_din = {8'hd8,data_buffer_fifo,CRC4};

fifo_FEB_ROD_TX FEB_TX_fifo_inst(
.wr_clk (write_clk),
.wr_rst (reset),
.rd_clk (TX_clk),
.rd_rst (reset),
.din    (fifo_din),
.wr_en  (fifo_wr_en & (~fifo_full)),
.rd_en  (fifo_rd_en),
.dout   (fifo_dout),
.full   (fifo_full),
.empty  (fifo_empty)
    ); 
    
//  serialize data
// output LSB of packet first; serial_out = serialize_data_buffer2[0]
(* KEEP="TRUE" *)reg [5:0]   bit_counter             = 6'd0;                                 // bit number 0~63
(* KEEP="TRUE" *)reg [63:0]  serialize_data_buffer1  = 64'hca55_5555_5555_5555;              // buffer fifo data
(* KEEP="TRUE" *)reg [63:0]  serialize_data_buffer2  = 64'hca55_5555_5555_5555;
(* KEEP="TRUE" *)reg         data_packet_flag        = 1'b0;                                 // 1 -- data packet; 0 -- null packet
always@(posedge TX_clk)
    begin
        if(reset)
            begin
                bit_counter             <= 6'd0;
                fifo_rd_en              <= 1'b0;
                data_packet_flag        <= 1'b0;  
                serialize_data_buffer1  <= 64'hca55_5555_5555_5555;
                serialize_data_buffer2  <= 64'hca55_5555_5555_5555;
            end
        else
            begin
                if(bit_counter == 6'd32)                                                                    // prepare next packet
                    begin
                        if(fifo_empty)  
                            begin
                                fifo_rd_en          <= 1'b0;
                                data_packet_flag    <= 1'b0;  
                            end
                        else                                                                                // if fifo empty, not read fifo; else read one packet from fifo
                            begin
                                fifo_rd_en          <= 1'b1;                                                        
                                data_packet_flag    <= 1'b1; 
                            end
                        serialize_data_buffer1  <= serialize_data_buffer1;                                          
                        serialize_data_buffer2  <= {1'b0,serialize_data_buffer2[63:1]};
                    end
                else if(bit_counter == 6'd62)
                    begin
                        if(data_packet_flag == 1'b1)  serialize_data_buffer1  <= fifo_dout;                 // load a data packet from fifo
                        else    serialize_data_buffer1  <= 64'hca55_5555_5555_5555;                         // fifo empty, output null packet
                        fifo_rd_en              <= 1'b0;
                        data_packet_flag        <= 1'b0;
                        serialize_data_buffer2  <= {1'b0,serialize_data_buffer2[63:1]};
                    end
                else if(bit_counter == 6'd63)
                    begin
                        serialize_data_buffer1  <= serialize_data_buffer1;
                        serialize_data_buffer2  <= serialize_data_buffer1;                                  // update serialize_data_buffer2
                        fifo_rd_en              <= 1'b0;
                        data_packet_flag        <= 1'b0;
                    end
                else
                    begin
                        serialize_data_buffer1  <= serialize_data_buffer1;
                        serialize_data_buffer2  <= {1'b0,serialize_data_buffer2[63:1]};
                        fifo_rd_en              <= 1'b0;
                        data_packet_flag        <= data_packet_flag;
                    end
                bit_counter <= bit_counter + 1'b1;
            end
    end

assign  TX_data_o = serialize_data_buffer2[0];

// TX ready
(* KEEP="TRUE" *)reg         TX_ready_r      = 1'b0;
(* KEEP="TRUE" *)reg [7:0]   empty_counter   = 8'h00;
always@(posedge TX_clk)
    begin
        if(reset || ~fifo_empty)
            begin
                TX_ready_r      <= 1'b0;
                empty_counter   <= 8'h00;
            end
        else 
            begin
                if(empty_counter < 8'ha0)
                    begin
                        TX_ready_r      <= 1'b0;
                        empty_counter   <= empty_counter + 1'b1;
                    end
                else                                    // fifo empty keeps over 160 cycles
                    begin
                        TX_ready_r      <= 1'b1;
                        empty_counter   <= 8'hc0;
                    end
            end
    end

assign TX_ready = TX_ready_r;


// ila
//wire [199:0] probe0 = {TX_data_o,FEB_select,fifo_empty,fifo_full,fifo_dout,fifo_rd_en,bit_counter,serialize_data_buffer1,serialize_data_buffer2,data_packet_flag};
  
//ila_0  ila_encode_inst
//(
//.clk(TX_clk),
//.probe0(probe0)
//);     
       
endmodule
