`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/23 23:27:45
// Design Name: 
// Module Name: RODlink_Data_Decode
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


// input data (40 bits)     ailgned data (36bits)        desscrambled data (36 bits)     CRC check (32 bits)        output data (32 bits)
//      data_in        ---> remove 4-bit header      --->       descrambler         ---> check and remove CRC   --->    data_out

module RODlink_Data_Decode(
    input           clk,
    input           reset,
    input   [39:0]  rx_data_in,
    output  [31:0]  decoded_data_out,
    output          decoded_data_valid,
    output          decoded_data_CRC,
    output          rx_data_aligned
    );
    
// in GTX serial input, rx_data_in[39:0] LSB intput first, set in GTX IP core

// late --------------------------------------------------> early
// RX_data[39],RX_data[38],RX_data[37]......RX_data[1],RX_data[0] ================>> RX_data[39:0]

// buffer RX data for data alignment
reg [39:0]  data_in_r1 = 40'h00_0000_0000;
reg [39:0]  data_in_r2 = 40'h00_0000_0000;
reg [39:0]  data_in_r3 = 40'h00_0000_0000;
reg [39:0]  data_in_r4 = 40'h00_0000_0000;
always@(posedge clk)
    if(reset)
        begin
            data_in_r1  <= 40'h00_0000_0000;
            data_in_r2  <= 40'h00_0000_0000;
            data_in_r3  <= 40'h00_0000_0000;
            data_in_r4  <= 40'h00_0000_0000;        
        end
    else
    begin
            data_in_r1  <= rx_data_in;
            data_in_r2  <= data_in_r1;
            data_in_r3  <= data_in_r2;
            data_in_r4  <= data_in_r3;
    end
 
//  data alignment
//  RX late -------------------------------------------------------------------> RX early
//  data_r2[39]......data_r2[0], data_r3[39]......data_r3[0], data_r4[39]......data_r4[0]

reg [5:0]   position        = 6'd0;            // position of header in packet
reg [35:0]  data_aligned    = 36'h0_0000_0000;
reg         align_flag      = 1'b0;
reg [3:0]   header          = 4'b1011;          // header "1011" -- comma/null packet, header "1100" -- data packet 
always@(posedge clk)
    begin
        if(reset)    
            begin
                position    	<= 6'd0;     
                align_flag  	<= 1'b0;
                data_aligned 	<= 36'h0_0000_0000;
                header      	<= 4'b1011;
            end
        else if(((data_in_r2[39:36] == 4'b1011)||(data_in_r2[39:36] == 4'b1100))&&((data_in_r3[39:36] == 4'b1011)||(data_in_r3[39:36] == 4'b1100))&&(position == 6'd39))            // data packet or null packet                   
            begin
                position        <= 6'd39;
                data_aligned    <= data_in_r3[35:0];
                align_flag      <= 1'b1;
                header          <= data_in_r3[39:36];
            end
        else if(((data_in_r2[38:35] == 4'b1011)||(data_in_r2[38:35] == 4'b1100))&&((data_in_r3[38:35] == 4'b1011)||(data_in_r3[38:35] == 4'b1100))&&(position == 6'd38))                               
            begin
                position        <= 6'd38;
                data_aligned    <= {data_in_r3[34:0],data_in_r4[39]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[38:35];
            end
        else if(((data_in_r2[37:34] == 4'b1011)||(data_in_r2[37:34] == 4'b1100))&&((data_in_r3[37:34] == 4'b1011)||(data_in_r3[37:34] == 4'b1100))&&(position == 6'd37))                               
            begin
                position        <= 6'd37;
                data_aligned    <= {data_in_r3[33:0],data_in_r4[39:38]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[37:34];
            end
        else if(((data_in_r2[36:33] == 4'b1011)||(data_in_r2[36:33] == 4'b1100))&&((data_in_r3[36:33] == 4'b1011)||(data_in_r3[36:33] == 4'b1100))&&(position == 6'd36))                            
            begin
                position        <= 6'd36;
                data_aligned    <= {data_in_r3[32:0],data_in_r4[39:37]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[36:33];
            end
        else if(((data_in_r2[35:32] == 4'b1011)||(data_in_r2[35:32] == 4'b1100))&&((data_in_r3[35:32] == 4'b1011)||(data_in_r3[35:32] == 4'b1100))&&(position == 6'd35))                               
            begin
                position        <= 6'd35;
                data_aligned    <= {data_in_r3[31:0],data_in_r4[39:36]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[35:32];
            end
        else if(((data_in_r2[34:31] == 4'b1011)||(data_in_r2[34:31] == 4'b1100))&&((data_in_r3[34:31] == 4'b1011)||(data_in_r3[34:31] == 4'b1100))&&(position == 6'd34))                               
            begin
                position        <= 6'd34;
                data_aligned    <= {data_in_r3[30:0],data_in_r4[39:35]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[34:31];
            end
        else if(((data_in_r2[33:30] == 4'b1011)||(data_in_r2[33:30] == 4'b1100))&&((data_in_r3[33:30] == 4'b1011)||(data_in_r3[33:30] == 4'b1100))&&(position == 6'd33))                               
            begin
                position        <= 6'd33;
                data_aligned    <= {data_in_r3[29:0],data_in_r4[39:34]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[33:30];
            end
        else if(((data_in_r2[32:29] == 4'b1011)||(data_in_r2[32:29] == 4'b1100))&&((data_in_r3[32:29] == 4'b1011)||(data_in_r3[32:29] == 4'b1100))&&(position == 6'd32))                               
            begin
                position        <= 6'd32;
                data_aligned    <= {data_in_r3[28:0],data_in_r4[39:33]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[32:29];
            end
        else if(((data_in_r2[31:28] == 4'b1011)||(data_in_r2[31:28] == 4'b1100))&&((data_in_r3[31:28] == 4'b1011)||(data_in_r3[31:28] == 4'b1100))&&(position == 6'd31))                               
            begin
                position        <= 6'd31;
                data_aligned    <= {data_in_r3[27:0],data_in_r4[39:32]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[31:28];
            end
        else if(((data_in_r2[30:27] == 4'b1011)||(data_in_r2[30:27] == 4'b1100))&&((data_in_r3[30:27] == 4'b1011)||(data_in_r3[30:27] == 4'b1100))&&(position == 6'd30))                               
            begin
                position        <= 6'd30;
                data_aligned    <= {data_in_r3[26:0],data_in_r4[39:31]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[30:27];
            end
        else if(((data_in_r2[29:26] == 4'b1011)||(data_in_r2[29:26] == 4'b1100))&&((data_in_r3[29:26] == 4'b1011)||(data_in_r3[29:26] == 4'b1100))&&(position == 6'd29))                               
            begin
                position        <= 6'd29;
                data_aligned    <= {data_in_r3[25:0],data_in_r4[39:30]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[29:26];
            end
        else if(((data_in_r2[28:25] == 4'b1011)||(data_in_r2[28:25] == 4'b1100))&&((data_in_r3[28:25] == 4'b1011)||(data_in_r3[28:25] == 4'b1100))&&(position == 6'd28))                               
            begin
                position        <= 6'd28;
                data_aligned    <= {data_in_r3[24:0],data_in_r4[39:29]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[28:25];
            end
        else if(((data_in_r2[27:24] == 4'b1011)||(data_in_r2[27:24] == 4'b1100))&&((data_in_r3[27:24] == 4'b1011)||(data_in_r3[27:24] == 4'b1100))&&(position == 6'd27))                               
            begin
                position        <= 6'd27;
                data_aligned    <= {data_in_r3[23:0],data_in_r4[39:28]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[27:24];
            end
        else if(((data_in_r2[26:23] == 4'b1011)||(data_in_r2[26:23] == 4'b1100))&&((data_in_r3[26:23] == 4'b1011)||(data_in_r3[26:23] == 4'b1100))&&(position == 6'd26))                               
            begin
                position        <= 6'd26;
                data_aligned    <= {data_in_r3[22:0],data_in_r4[39:27]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[26:23];
            end
        else if(((data_in_r2[25:22] == 4'b1011)||(data_in_r2[25:22] == 4'b1100))&&((data_in_r3[25:22] == 4'b1011)||(data_in_r3[25:22] == 4'b1100))&&(position == 6'd25))                               
            begin
                position        <= 6'd25;
                data_aligned    <= {data_in_r3[21:0],data_in_r4[39:26]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[25:22];
            end
        else if(((data_in_r2[24:21] == 4'b1011)||(data_in_r2[24:21] == 4'b1100))&&((data_in_r3[24:21] == 4'b1011)||(data_in_r3[24:21] == 4'b1100))&&(position == 6'd24))                               
            begin
                position        <= 6'd24;
                data_aligned    <= {data_in_r3[20:0],data_in_r4[39:25]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[24:21];
            end
        else if(((data_in_r2[23:20] == 4'b1011)||(data_in_r2[23:20] == 4'b1100))&&((data_in_r3[23:20] == 4'b1011)||(data_in_r3[23:20] == 4'b1100))&&(position == 6'd23))                               
            begin
                position        <= 6'd23;
                data_aligned    <= {data_in_r3[19:0],data_in_r4[39:24]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[23:20];
            end
        else if(((data_in_r2[22:19] == 4'b1011)||(data_in_r2[22:19] == 4'b1100))&&((data_in_r3[22:19] == 4'b1011)||(data_in_r3[22:19] == 4'b1100))&&(position == 6'd22))                               
            begin
                position        <= 6'd22;
                data_aligned    <= {data_in_r3[18:0],data_in_r4[39:23]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[22:19];
            end
        else if(((data_in_r2[21:18] == 4'b1011)||(data_in_r2[21:18] == 4'b1100))&&((data_in_r3[21:18] == 4'b1011)||(data_in_r3[21:18] == 4'b1100))&&(position == 6'd21))                               
            begin
                position        <= 6'd21;
                data_aligned    <= {data_in_r3[17:0],data_in_r4[39:22]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[21:18];
            end
        else if(((data_in_r2[20:17] == 4'b1011)||(data_in_r2[20:17] == 4'b1100))&&((data_in_r3[20:17] == 4'b1011)||(data_in_r3[20:17] == 4'b1100))&&(position == 6'd20))                               
            begin
                position        <= 6'd20;
                data_aligned    <= {data_in_r3[16:0],data_in_r4[39:21]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[20:17];
            end
        else if(((data_in_r2[19:16] == 4'b1011)||(data_in_r2[19:16] == 4'b1100))&&((data_in_r3[19:16] == 4'b1011)||(data_in_r3[19:16] == 4'b1100))&&(position == 6'd19))                               
            begin
                position        <= 6'd19;
                data_aligned    <= {data_in_r3[15:0],data_in_r4[39:20]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[19:16];
            end
        else if(((data_in_r2[18:15] == 4'b1011)||(data_in_r2[18:15] == 4'b1100))&&((data_in_r3[18:15] == 4'b1011)||(data_in_r3[18:15] == 4'b1100))&&(position == 6'd18))                               
            begin
                position        <= 6'd18;
                data_aligned    <= {data_in_r3[14:0],data_in_r4[39:19]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[18:15];
            end
        else if(((data_in_r2[17:14] == 4'b1011)||(data_in_r2[17:14] == 4'b1100))&&((data_in_r3[17:14] == 4'b1011)||(data_in_r3[17:14] == 4'b1100))&&(position == 6'd17))                               
            begin
                position        <= 6'd17;
                data_aligned    <= {data_in_r3[13:0],data_in_r4[39:18]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[17:14];
            end
        else if(((data_in_r2[16:13] == 4'b1011)||(data_in_r2[16:13] == 4'b1100))&&((data_in_r3[16:13] == 4'b1011)||(data_in_r3[16:13] == 4'b1100))&&(position == 6'd16))                               
            begin
                position        <= 6'd16;
                data_aligned    <= {data_in_r3[12:0],data_in_r4[39:17]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[16:13];
            end
        else if(((data_in_r2[15:12] == 4'b1011)||(data_in_r2[15:12] == 4'b1100))&&((data_in_r3[15:12] == 4'b1011)||(data_in_r3[15:12] == 4'b1100))&&(position == 6'd15))                               
            begin
                position        <= 6'd15;
                data_aligned    <= {data_in_r3[11:0],data_in_r4[39:16]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[15:12];
            end
        else if(((data_in_r2[14:11] == 4'b1011)||(data_in_r2[14:11] == 4'b1100))&&((data_in_r3[14:11] == 4'b1011)||(data_in_r3[14:11] == 4'b1100))&&(position == 6'd14))                               
            begin
                position        <= 6'd14;
                data_aligned    <= {data_in_r3[10:0],data_in_r4[39:15]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[14:11];
            end
        else if(((data_in_r2[13:10] == 4'b1011)||(data_in_r2[13:10] == 4'b1100))&&((data_in_r3[13:10] == 4'b1011)||(data_in_r3[13:10] == 4'b1100))&&(position == 10'd13))                               
            begin
                position        <= 6'd13;
                data_aligned    <= {data_in_r3[9:0],data_in_r4[39:14]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[13:10];
            end
        else if(((data_in_r2[12:9] == 4'b1011)||(data_in_r2[12:9] == 4'b1100))&&((data_in_r3[12:9] == 4'b1011)||(data_in_r3[12:9] == 4'b1100))&&(position == 6'd12))                               
            begin
                position        <= 6'd12;
                data_aligned    <= {data_in_r3[8:0],data_in_r4[39:13]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[12:9];
            end
        else if(((data_in_r2[11:8] == 4'b1011)||(data_in_r2[11:8] == 4'b1100))&&((data_in_r3[11:8] == 4'b1011)||(data_in_r3[11:8] == 4'b1100))&&(position == 6'd11))                               
            begin
                position        <= 6'd11;
                data_aligned    <= {data_in_r3[7:0],data_in_r4[39:12]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[11:8];
            end
        else if(((data_in_r2[10:7] == 4'b1011)||(data_in_r2[10:7] == 4'b1100))&&((data_in_r3[10:7] == 4'b1011)||(data_in_r3[10:7] == 4'b1100))&&(position == 6'd10))                               
            begin
                position        <= 6'd10;
                data_aligned    <= {data_in_r3[6:0],data_in_r4[39:11]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[10:7];
            end
        else if(((data_in_r2[9:6] == 4'b1011)||(data_in_r2[9:6] == 4'b1100))&&((data_in_r3[9:6] == 4'b1011)||(data_in_r3[9:6] == 4'b1100))&&(position == 6'd9))                               
            begin
                position        <= 6'd9;
                data_aligned    <= {data_in_r3[5:0],data_in_r4[39:10]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[9:6];
            end
        else if(((data_in_r2[8:5] == 4'b1011)||(data_in_r2[8:5] == 4'b1100))&&((data_in_r3[8:5] == 4'b1011)||(data_in_r3[8:5] == 4'b1100))&&(position == 6'd8))                               
            begin
                position        <= 6'd8;
                data_aligned    <= {data_in_r3[4:0],data_in_r4[39:9]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[8:5];
            end
        else if(((data_in_r2[7:4] == 4'b1011)||(data_in_r2[7:4] == 4'b1100))&&((data_in_r3[7:4] == 4'b1011)||(data_in_r3[7:4] == 4'b1100))&&(position == 6'd7))                               
            begin
                position        <= 6'd7;
                data_aligned    <= {data_in_r3[3:0],data_in_r4[39:8]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[7:4];
            end
        else if(((data_in_r2[6:3] == 4'b1011)||(data_in_r2[6:3] == 4'b1100))&&((data_in_r3[6:3] == 4'b1011)||(data_in_r3[6:3] == 4'b1100))&&(position == 6'd6))                               
            begin
                position        <= 6'd6;
                data_aligned    <= {data_in_r3[2:0],data_in_r4[39:7]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[6:3];
            end			
        else if(((data_in_r2[5:2] == 4'b1011)||(data_in_r2[5:2] == 4'b1100))&&((data_in_r3[5:2] == 4'b1011)||(data_in_r3[5:2] == 4'b1100))&&(position == 6'd5))                               
            begin
                position        <= 6'd5;
                data_aligned    <= {data_in_r3[1:0],data_in_r4[39:6]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[5:2];
            end				
        else if(((data_in_r2[4:1] == 4'b1011)||(data_in_r2[4:1] == 4'b1100))&&((data_in_r3[4:1] == 4'b1011)||(data_in_r3[4:1] == 4'b1100))&&(position == 6'd4))                               
            begin
                position        <= 6'd4;
                data_aligned    <= {data_in_r3[0],data_in_r4[39:5]};
                align_flag      <= 1'b1;
                header          <= data_in_r3[4:1];
            end				
        else if(((data_in_r2[3:0] == 4'b1011)||(data_in_r2[3:0] == 4'b1100))&&((data_in_r3[3:0] == 4'b1011)||(data_in_r3[3:0] == 4'b1100))&&(position == 6'd3))                               
            begin
                position        <= 6'd3;
                data_aligned    <= data_in_r4[39:4];
                align_flag      <= 1'b1;
                header          <= data_in_r3[3:0];
            end						
        else if((({data_in_r2[2:0],data_in_r3[39]} == 4'b1011)||({data_in_r2[2:0],data_in_r3[39]} == 4'b1100))&&(({data_in_r3[2:0],data_in_r4[39]} == 4'b1011)||({data_in_r3[2:0],data_in_r4[39]} == 4'b1100))&&(position == 6'd2))     
            begin
                position        <= 6'd2;
                data_aligned    <= data_in_r4[38:3];
                align_flag      <= 1'b1;
                header          <= {data_in_r3[2:0],data_in_r4[39]};
            end
        else if((({data_in_r2[1:0],data_in_r3[39:38]} == 4'b1011)||({data_in_r2[1:0],data_in_r3[39:38]} == 4'b1100))&&(({data_in_r3[1:0],data_in_r4[39:38]} == 4'b1011)||({data_in_r3[1:0],data_in_r4[39:38]} == 4'b1100))&&(position == 6'd1))     
            begin
                position        <= 6'd1;
                data_aligned    <= data_in_r4[37:2];
                align_flag      <= 1'b1;
                header          <= {data_in_r3[1:0],data_in_r4[39:38]};
            end
        else if((({data_in_r2[0],data_in_r3[39:37]} == 4'b1011)||({data_in_r2[0],data_in_r3[39:37]} == 4'b1100))&&(({data_in_r3[0],data_in_r4[39:37]} == 4'b1011)||({data_in_r3[0],data_in_r4[39:37]} == 4'b1100))&&(position == 6'd0))     
            begin
                position        <= 6'd0;
                data_aligned    <= data_in_r4[36:1];
                align_flag      <= 1'b1;
                header          <= {data_in_r3[0],data_in_r4[39:37]};
            end
        else    
            begin
                if(position == 6'd39)   position    <= 6'd0; 
                else    position    <= position + 1'b1; 
                data_aligned    <= 36'h0_0000_0000;
                align_flag		<= 1'b0;
                header          <= 4'b1011;
            end    
    end    		

// align_flag = 1 keeps over 4'hd clk cycles  ==> real_aligned = 1, otherwise unaligned
reg         real_aligned = 1'b0;
reg [3:0]   hold_counter = 4'h0;
always@(posedge clk)
    if(reset)
        begin
            real_aligned    <= 1'b0;
            hold_counter    <= 4'h0;        
        end
    else if(position < 6'd40)                                       // valid header position
        begin
            if((align_flag == 1'b1)&&(hold_counter < 4'hd))
                begin
                    real_aligned <= 1'b0;
                    hold_counter <= hold_counter + 1'b1;
                end
            else if((align_flag == 1'b1)&&(hold_counter == 4'hd))    // align_flag keeps 1'b1;
                begin
                    real_aligned <= 1'b1;
                    hold_counter <= 4'hd;
                end
            else
                begin
                    real_aligned  <= 1'b0;
                    hold_counter <= 4'h0;             
                end
        end
    else
        begin
            real_aligned  <= 1'b0;
            hold_counter <= 4'h0;
        end

// pick out data packet, remove null packet
reg         data_valid  = 1'b0;
reg [35:0]  data_packet = 36'h0_0000_0000;
always@(posedge clk) 
    begin
        if(reset)
            begin
                data_valid  <= 1'b0;
                data_packet <= 36'h0_0000_0000;        
            end
        else if(header == 4'b1100)                  // data packet
            begin
                data_valid  <= 1'b1;
                data_packet <= data_aligned;
            end
        else    
            begin
                data_valid  <= 1'b0;
                data_packet <= 36'h0_0000_0000;
            end
    end

// data descrambler (polynomial = X58 + X39 + 1)       
    reg     [57:0]                 descrambler= 58'h155_5555_5555_5555;
    reg     [57:0]                 poly = 58'h155_5555_5555_5555;
    reg     [35:0]                 tempData;
    reg                            xorBit;
    integer                        i;
always @(descrambler,data_packet)
    begin
        poly = descrambler;
        for (i=0;i<=35;i=i+1)
            begin
                xorBit      = data_packet[i] ^ poly[38] ^ poly[57];
                poly        = {poly[56:0],data_packet[i]};
                tempData[i] = xorBit;
            end
    end

reg [35:0]  descrambled_data = 36'h0_0000_0000;
reg         CRC_enable       = 1'b0;                            // enable CRC check
always @(posedge clk)                                            // descramble data
    begin
        if(reset)
            begin
                descrambled_data    <=  36'h0_0000_0000;
                descrambler         <=  58'h155_5555_5555_5555;
                CRC_enable          <= 1'b0;
            end
        else if (real_aligned && data_valid)
            begin
                descrambled_data    <=  tempData;
                descrambler         <=  poly;
                CRC_enable          <= 1'b1;
            end
        else
            begin
                descrambled_data    <=  36'h0_0000_0000;
                descrambler         <=  58'h155_5555_5555_5555;   
                CRC_enable          <= 1'b0;         
            end
    end     

// CRC check (X4 + X + 1)
wire [31:0] data_in_CRC;                            // data bits of data packet
wire [3:0]  packet_CRC;                             // CRC bits of data packet
assign  data_in_CRC = descrambled_data[35:4];
assign  packet_CRC  = descrambled_data[3:0];

reg [3:0]   CRC4_result     = 4'b0000;              // CRC calculate result of data packet
reg [3:0]   CRC4_buffer     = 4'b0000;              // buffer CRC bits of data packet
reg [31:0]  data_buffer_CRC = 32'h0000_0000;        // buffer data bits of data packet
reg         CRC_compare     = 1'b0;                 // compare CRC4_result with CRC4_buffer, when CRC_compare = 1'b1;
always@(posedge clk)
    begin
        if(reset)
            begin
                CRC4_result     <= 4'b0000;
                CRC4_buffer     <= 4'b0000;
                data_buffer_CRC <= 32'h0000_0000;
                CRC_compare     <= 1'b0;
            end
        else if(CRC_enable == 1'b1)                             // calculate CRC4_result
            begin
				CRC4_result[0]  <= 1'b0 ^ data_in_CRC[0] ^ data_in_CRC[3] ^ data_in_CRC[4] ^ data_in_CRC[6] ^ data_in_CRC[8] ^ data_in_CRC[9] ^ data_in_CRC[10] ^ data_in_CRC[11] ^ data_in_CRC[15] ^ data_in_CRC[18] ^ data_in_CRC[19] ^ data_in_CRC[21] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[25] ^ data_in_CRC[26] ^ data_in_CRC[30];
				CRC4_result[1]  <= 1'b0 ^ 1'b0           ^ data_in_CRC[0] ^ data_in_CRC[1] ^ data_in_CRC[3] ^ data_in_CRC[5] ^ data_in_CRC[6] ^ data_in_CRC[7]  ^ data_in_CRC[8]  ^ data_in_CRC[12] ^ data_in_CRC[15] ^ data_in_CRC[16] ^ data_in_CRC[18] ^ data_in_CRC[20] ^ data_in_CRC[21] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[27] ^ data_in_CRC[30] ^ data_in_CRC[31];
				CRC4_result[2]  <= 1'b0 ^ 1'b0           ^ data_in_CRC[1] ^ data_in_CRC[2] ^ data_in_CRC[4] ^ data_in_CRC[6] ^ data_in_CRC[7] ^ data_in_CRC[8]  ^ data_in_CRC[9]  ^ data_in_CRC[13] ^ data_in_CRC[16] ^ data_in_CRC[17] ^ data_in_CRC[19] ^ data_in_CRC[21] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[28] ^ data_in_CRC[31];
				CRC4_result[3]  <= 1'b0 ^ data_in_CRC[2] ^ data_in_CRC[3] ^ data_in_CRC[5] ^ data_in_CRC[7] ^ data_in_CRC[8] ^ data_in_CRC[9] ^ data_in_CRC[10] ^ data_in_CRC[14] ^ data_in_CRC[17] ^ data_in_CRC[18] ^ data_in_CRC[20] ^ data_in_CRC[22] ^ data_in_CRC[23] ^ data_in_CRC[24] ^ data_in_CRC[25] ^ data_in_CRC[29];
                data_buffer_CRC <= data_in_CRC;
                CRC_compare     <= 1'b1;                        // enable CRC check
                CRC4_buffer     <= packet_CRC;
            end
        else
            begin
                CRC4_result     <= 4'b0000;
                data_buffer_CRC <= 32'h0000_0000;
                CRC_compare     <= 1'b0;         
                CRC4_buffer     <= 4'b0000;   
            end       
        end

(*keep = "true"*)reg         decoded_data_valid_r = 1'b0;                            // decoded_data_valid means packet format is right
(*keep = "true"*)reg         decoded_data_CRC_r   = 1'b0;                            // decoded_data_CRC means packet pass the CRC check 
(*keep = "true"*)reg [31:0]  decoded_data_r       = 32'h0000_0000;                   // VMM data 
always@(posedge clk)
    begin
        if(reset)
            begin
                decoded_data_CRC_r      <= 1'b0;
                decoded_data_r          <= 32'h0000_0000;
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
                decoded_data_r          <= 32'h0000_0000;
                decoded_data_valid_r    <= 1'b0;          
            end       
        end
        

assign  decoded_data_CRC    = decoded_data_CRC_r;   
assign  decoded_data_out    = decoded_data_r;
assign  decoded_data_valid  = decoded_data_valid_r;
assign  rx_data_aligned     = real_aligned;    



//////    
//reg [19:0]  VMM_1_chl_counter = 20'h00000;
//reg [19:0]  VMM_2_chl_counter = 20'h00000;
//reg [19:0]  VMM_3_chl_counter = 20'h00000;
//reg [19:0]  VMM_4_chl_counter = 20'h00000;

//wire [5:0]  VMM_chl_set;
//wire        hits_reset;    

//vio_0 VMM_chl_hit_vio
//(
//.clk(clk),
//.probe_out0(hits_reset),
//.probe_out1(VMM_chl_set)
//);    

//always@(posedge clk)    
//    begin
//        if(hits_reset)
//            begin
//                VMM_1_chl_counter   <= 20'h00000;
//                VMM_2_chl_counter   <= 20'h00000;
//                VMM_3_chl_counter   <= 20'h00000;
//                VMM_4_chl_counter   <= 20'h00000;
//            end
//        else if((decoded_data_valid_r == 1'b1)&&(decoded_data_r[27:22] == VMM_chl_set[5:0]))
//            begin
//                if(decoded_data_r[31:29] == 3'b100) VMM_1_chl_counter <= VMM_1_chl_counter + 1'b1;
//                else if(decoded_data_r[31:29] == 3'b101) VMM_2_chl_counter <= VMM_2_chl_counter + 1'b1;
//                else if(decoded_data_r[31:29] == 3'b110) VMM_3_chl_counter <= VMM_3_chl_counter + 1'b1;
//                else if(decoded_data_r[31:29] == 3'b111) VMM_4_chl_counter <= VMM_4_chl_counter + 1'b1;
//            end
//        else
//            begin
//                VMM_1_chl_counter   <= VMM_1_chl_counter;
//                VMM_2_chl_counter   <= VMM_2_chl_counter;
//                VMM_3_chl_counter   <= VMM_3_chl_counter;
//                VMM_4_chl_counter   <= VMM_4_chl_counter;            
//            end    
//    end




// ila
 /* wire [298:0] probe0;
assign probe0 = {data_aligned,decoded_data_valid_r,decoded_data_CRC_r,decoded_data_r,data_in_r2,real_aligned};

ila_GTX_Decode  ila_decode_inst
(
.clk(clk),
.probe0(probe0)
);  */
        
endmodule
