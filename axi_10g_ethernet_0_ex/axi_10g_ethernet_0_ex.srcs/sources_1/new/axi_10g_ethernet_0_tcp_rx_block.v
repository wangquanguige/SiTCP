`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 17:07:32
// Design Name: 
// Module Name: axi_10g_ethernet_0_tcp_rx_block
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


module axi_10g_ethernet_0_tcp_rx_block(
    input                   aclk,
    input                   areset,

    input       [63:0]      rx_tdata,
    input       [7:0]       rx_tkeep,
    input                   rx_tvalid,
    input                   rx_tlast,

    output       [63:0]     inter_tdata,
    output       [7:0]      inter_tkeep,
    output                  inter_tvalid,
    output                  inter_tlast
    );

    assign inter_tdata = rx_tdata;
    assign inter_tkeep = rx_tkeep;
    assign inter_tvalid = rx_tvalid;
    assign inter_tlast = rx_tlast;


endmodule
