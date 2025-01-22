`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/23 23:27:19
// Design Name: 
// Module Name: RODlink_Data_Encode
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


// input data (32 bits)     data with CRC (36 bits)     scrambled data (36 bits)        output data with header (40 bits)
//      data_in        ---> data_in + 4 bits CRC4   --->        scrambler          ---> 4 bits header + scrambled data

module RODlink_Data_Encode
(
    input           clk,
    input           reset,
    input   [31:0]  data_in,
    input           data_valid,
    output  [39:0]  TX_data_out
    );
 
reg [31:0]  data_in_r       = 32'h0000_0000;
reg         data_valid_r    = 1'b0;
reg [31:0]  data_buffer_CRC = 32'h0000_0000;        // buffer data for CRC
reg         CRC_enable      = 1'b0;                 // enable CRC
always@(posedge clk)
    begin
        if(reset)
            begin
                data_in_r       <= 32'h0000_0000;
                data_valid_r    <= 1'b0;
                data_buffer_CRC <= 32'h0000_0000;
                CRC_enable      <= 1'b0;
            end
        else if(data_valid_r == 1'b1)
            begin
                data_buffer_CRC <= data_in_r;
                CRC_enable      <= 1'b1;                // enable CRC calculate when input data valid
                data_in_r       <= data_in;
                data_valid_r    <= data_valid;         
            end
        else
            begin
                data_buffer_CRC <= 32'h0000_0000;
                CRC_enable      <= 1'b0;
                data_in_r       <= data_in;
                data_valid_r    <= data_valid;              
            end
    end    


// calculate CRC4 (X4 + X + 1)    
reg [3:0]   CRC4                    = 4'b0000;          // 4-bit CRC result
reg [31:0]  data_buffer_scramble    = 32'h0000_0000;    // buffer data for scramble
reg         scramble_enable         = 1'b0;             // enabel scramble
always@(posedge clk)
    begin
        if(reset)
            begin
                CRC4                    <= 4'b0000;
                data_buffer_scramble    <= 32'h0000_0000;
                scramble_enable         <= 1'b0;
            end
        else if(CRC_enable == 1'b1)                             // calculate CRC4
            begin
				CRC4[0]                 <= 1'b0 ^ data_buffer_CRC[0] 	^ data_buffer_CRC[3] ^ data_buffer_CRC[4] ^ data_buffer_CRC[6] ^ data_buffer_CRC[8] ^ data_buffer_CRC[9] ^ data_buffer_CRC[10] ^ data_buffer_CRC[11] ^ data_buffer_CRC[15] ^ data_buffer_CRC[18] ^ data_buffer_CRC[19] ^ data_buffer_CRC[21] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[25] ^ data_buffer_CRC[26] ^ data_buffer_CRC[30];
				CRC4[1]                 <= 1'b0 ^ 1'b0 			        ^ data_buffer_CRC[0] ^ data_buffer_CRC[1] ^ data_buffer_CRC[3] ^ data_buffer_CRC[5] ^ data_buffer_CRC[6] ^ data_buffer_CRC[7]  ^ data_buffer_CRC[8]  ^ data_buffer_CRC[12] ^ data_buffer_CRC[15] ^ data_buffer_CRC[16] ^ data_buffer_CRC[18] ^ data_buffer_CRC[20] ^ data_buffer_CRC[21] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[27] ^ data_buffer_CRC[30] ^ data_buffer_CRC[31];
				CRC4[2]                 <= 1'b0 ^ 1'b0 			        ^ data_buffer_CRC[1] ^ data_buffer_CRC[2] ^ data_buffer_CRC[4] ^ data_buffer_CRC[6] ^ data_buffer_CRC[7] ^ data_buffer_CRC[8]  ^ data_buffer_CRC[9]  ^ data_buffer_CRC[13] ^ data_buffer_CRC[16] ^ data_buffer_CRC[17] ^ data_buffer_CRC[19] ^ data_buffer_CRC[21] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[28] ^ data_buffer_CRC[31];
				CRC4[3]                 <= 1'b0 ^ data_buffer_CRC[2] 	^ data_buffer_CRC[3] ^ data_buffer_CRC[5] ^ data_buffer_CRC[7] ^ data_buffer_CRC[8] ^ data_buffer_CRC[9] ^ data_buffer_CRC[10] ^ data_buffer_CRC[14] ^ data_buffer_CRC[17] ^ data_buffer_CRC[18] ^ data_buffer_CRC[20] ^ data_buffer_CRC[22] ^ data_buffer_CRC[23] ^ data_buffer_CRC[24] ^ data_buffer_CRC[25] ^ data_buffer_CRC[29];
                data_buffer_scramble    <= data_buffer_CRC;
                scramble_enable         <= 1'b1;                // enable scramble
            end
        else
            begin
                CRC4                    <= 4'b0000;
                data_buffer_scramble    <= 32'h0000_0000;
                scramble_enable         <= 1'b0;            
            end       
        end

// data scrambler (polynomial = X58 + X39 + 1)        
reg     [57:0]  scrambler   = 58'h155_5555_5555_5555;
reg     [57:0]  poly        = 58'h155_5555_5555_5555;
reg     [35:0]  tempData;
integer         i;
reg             xorBit;
wire    [35:0]  unscrambled_data_in;

assign  unscrambled_data_in = {data_buffer_scramble,CRC4};

always @(scrambler,unscrambled_data_in)         // scramble data
    begin
        poly = scrambler;
        for (i=0;i<=35;i=i+1)
            begin
                xorBit      = unscrambled_data_in[i] ^ poly[38] ^ poly[57];
                poly        = {poly[56:0],xorBit};
                tempData[i] = xorBit;
            end
    end
  
reg [39:0]  scrambled_data_out  = 40'hb4_aaaa_aaaa;                 // with 4-bit header, header "1011" -- comma/null packet, header "1100" -- data packet 
always @(posedge clk)
    begin
        if (reset)
            begin
                scrambled_data_out  <=   40'hb4_aaaa_aaaa;          // null packet without CRC and scramble
                scrambler           <=   58'h155_5555_5555_5555;
            end
        else if(scramble_enable == 1'b1)                            // scrambled data output
            begin
                scrambled_data_out  <=   {4'b1100,tempData};        // valid data
                scrambler           <=   poly;
            end
        else
            begin
                scrambled_data_out  <=   40'hb4_aaaa_aaaa;
                scrambler           <=   58'h155_5555_5555_5555;
            end
    end    
 
assign  TX_data_out = scrambled_data_out;                           // in GTX serial output, LSB of TX_data_out send out first, MSB of TX_data_out send out last, set by GTX IP core


// ila
//wire [236:0] probe0 = {data_in_r,data_valid_r,data_buffer_CRC,CRC_enable,CRC4,data_buffer_scramble,scramble_enable,poly,tempData,scrambled_data_out};
  
//ila_GTX_Encode  ila_encode_inst
//(
//.clk(clk),
//.probe0(probe0)
//);
            
endmodule
