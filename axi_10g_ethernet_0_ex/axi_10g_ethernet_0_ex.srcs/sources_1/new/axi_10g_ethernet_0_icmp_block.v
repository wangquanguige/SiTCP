`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/10 14:24:27
// Design Name: 
// Module Name: axi_10g_ethernet_0_icmp_block
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


module axi_10g_ethernet_0_icmp_block #(
    // 配置参数，show_output_block显示输出数据属于哪个模块，show_message_type显示接收报文类型
    parameter  show_output_block            =           1           ,
    parameter  show_message_type            =           1           
)
(
   input wire                          aclk                     ,
   input wire                          areset                   ,

   // data from the RX data path
   input       [63:0]                  rx_axis_tdata            ,
   input       [7:0]                   rx_axis_tkeep            ,
   input                               rx_axis_tvalid           ,
   input                               rx_axis_tlast            ,
   output                              rx_axis_tready           ,

   // data to the TX data path
   output      [63:0]                  tx_axis_tdata            ,
   output      [7:0]                   tx_axis_tkeep            ,
   output                              tx_axis_tvalid           ,
   output                              tx_axis_tlast            ,
   input                               tx_axis_tready           ,

   // 上层需要执行ping操作
   input       [31:0]                  icmp_request_ip          ,
   input                               icmp_request_en          
);

wire                        tx_icmp_en          ;
wire        [47:0]          icmp_src_mac        ;
wire        [31:0]          icmp_src_ip         ;  

axi_10g_ethernet_0_icmp_parser #(
    .show_message_type                  (1)                     
)
icmp_parser (
    .aclk                               (aclk)                  ,      
    .areset                             (areset)                ,

    .rx_axis_tdata                      (rx_axis_tdata)         ,
    .rx_axis_tkeep                      (rx_axis_tkeep)         ,
    .rx_axis_tvalid                     (rx_axis_tvalid)        ,
    .rx_axis_tlast                      (rx_axis_tlast)         ,
    .rx_axis_tready                     (rx_axis_tready)        ,

    .tx_icmp_en                         (tx_icmp_en)            , 
    .icmp_src_mac                       (icmp_src_mac)          ,
    .icmp_src_ip                        (icmp_src_ip)           
);

axi_10g_ethernet_0_icmp_generator #(
    .show_output_block                  (1)
)
icmp_generator (
    .aclk                               (aclk)                  ,      
    .areset                             (areset)                ,

    .tx_icmp_en                         (tx_icmp_en)            , 
    .icmp_src_mac                       (icmp_src_mac)          ,
    .icmp_src_ip                        (icmp_src_ip)           ,

    .tx_axis_tdata                      (tx_axis_tdata)         ,
    .tx_axis_tkeep                      (tx_axis_tkeep)         ,
    .tx_axis_tvalid                     (tx_axis_tvalid)        ,
    .tx_axis_tlast                      (tx_axis_tlast)         ,
    .tx_axis_tready                     (tx_axis_tready)        ,   

    .icmp_request_ip                    (icmp_request_ip)       ,
    .icmp_request_en                    (icmp_request_en)
);

endmodule
