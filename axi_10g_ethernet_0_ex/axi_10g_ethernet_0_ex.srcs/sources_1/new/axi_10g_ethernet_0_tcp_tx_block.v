`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 17:08:00
// Design Name: 
// Module Name: axi_10g_ethernet_0_tcp_tx_block
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


module axi_10g_ethernet_0_tcp_tx_block(
      input                 aclk                           ,
      input                 areset                         ,

      input       [63:0]    tx_tdata                       ,
      input       [7:0]     tx_tkeep                       ,
      input                 tx_tvalid                      ,
      input                 tx_tlast                       ,

      output      [63:0]    inter_tdata                    ,
      output      [7:0]     inter_tkeep                    ,
      output                inter_tvalid                   ,
      output                inter_tlast                    
    );

    assign inter_tdata = tx_tdata;
    assign inter_tkeep = tx_tkeep;
    assign inter_tvalid = tx_tvalid;
    assign inter_tlast = tx_tlast;

endmodule
