`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/22 10:20:49
// Design Name: 
// Module Name: PowerOnReset
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


module PowerOnReset(
input   clk,
output  reset
    );
    
reg [15:0]  reset_counter = 16'h0000;
reg         reset_r       = 1'b0;
always@(posedge clk)  
    begin
        if(reset_counter < 16'hff00)
            begin
                reset_counter   <= reset_counter + 1'b1;
                reset_r         <= 1'b1;
            end
        else
            begin
                reset_counter   <= 16'hfff0;
                reset_r         <= 1'b0;            
            end
    end  

assign reset = reset_r;    
        
endmodule
