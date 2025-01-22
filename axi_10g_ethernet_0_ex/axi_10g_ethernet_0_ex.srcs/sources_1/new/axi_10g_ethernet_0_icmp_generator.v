`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/08 15:24:51
// Design Name: 
// Module Name: axi_10g_ethernet_0_icmp_generator
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


module axi_10g_ethernet_0_icmp_generator #(
    parameter           show_output_block           =           1           
)
(
    input                               aclk                    ,
    input                               areset                  ,

    // 接收parser模块解析数据
    input                               tx_icmp_en              ,
    input       [47:0]                  icmp_src_mac            ,
    input       [31:0]                  icmp_src_ip             ,

    // 输出数据
    output      [63:0]                  tx_axis_tdata           ,
    output      [7:0]                   tx_axis_tkeep           ,
    output                              tx_axis_tvalid          ,
    output                              tx_axis_tlast           ,
    input                               tx_axis_tready          ,

    // 上层需要发送ping报文
    input       [31:0]                  icmp_request_ip         ,
    input                               ivmp_request_en           
);

axi_10g_ethernet_0_icmp_reply #(
    .show_output_block                  (1)                     
)
icmp_reply (
    .aclk                               (aclk)                     ,
    .areset                             (areset)                   ,
 
    .tx_icmp_en                         (tx_icmp_en)               ,
    .icmp_src_mac                       (icmp_src_mac)             ,
    .icmp_src_ip                        (icmp_src_ip)              ,

    .tx_axis_tdata                      (arp_reply_tdata)          ,
    .tx_axis_tkeep                      (arp_reply_tkeep)          ,
    .tx_axis_tvalid                     (arp_reply_tvalid)         ,
    .tx_axis_tlast                      (arp_reply_tlast)          
);

endmodule
