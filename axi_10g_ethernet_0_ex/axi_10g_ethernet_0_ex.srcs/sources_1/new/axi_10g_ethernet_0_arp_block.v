`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/30 15:23:04
// Design Name: 
// Module Name: axi_10g_ethernet_0_arp_block
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


module axi_10g_ethernet_0_arp_block #(
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

   // 上层传递数据时，先匹配ip地址是否有mac映射
   input       [31:0]                  arp_request_ip           ,
   input                               tx_tcp_en                ,
   output                              tx_tcp_tready            
);

wire                            arp_reply_tready        ;
wire                            tx_arp_en               ;
wire                            arp_rx_type             ;
wire            [47:0]          arp_src_mac             ;
wire            [31:0]          arp_src_ip              ;

axi_10g_ethernet_0_arp_parser #(
    .show_message_type               (show_message_type)
)
arp_parse (
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .rx_axis_tdata                   (rx_axis_tdata)            ,
    .rx_axis_tkeep                   (rx_axis_tkeep)            ,
    .rx_axis_tvalid                  (rx_axis_tvalid)           ,
    .rx_axis_tlast                   (rx_axis_tlast)            ,
    .rx_axis_tready                  (rx_axis_tready)           ,

    .tx_arp_en                       (tx_arp_en)                ,
    .arp_rx_type                     (arp_rx_type)              ,
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)               
);

axi_10g_ethernet_0_arp_generator #(
    .show_output_block               (show_output_block)     
)
arp_generator (
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .tx_arp_en                       (tx_arp_en)                ,
    .arp_rx_type                     (arp_rx_type)              ,
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)               ,

    .tx_axis_tdata                   (tx_axis_tdata)            ,
    .tx_axis_tkeep                   (tx_axis_tkeep)            ,
    .tx_axis_tvalid                  (tx_axis_tvalid)           ,
    .tx_axis_tlast                   (tx_axis_tlast)            ,
    .tx_axis_tready                  (tx_axis_tready)           ,

    .arp_request_ip                  (arp_request_ip)           ,       // tcp层发送报文的ip
    .tx_tcp_en                       (tx_tcp_en)                ,       // tcp发送报文使能信号
    .tx_tcp_tready                   (tx_tcp_tready)            ,       // tcp允许发送报文
    .tx_tcp_done                     (tx_tcp_done)                      // tcp发送完成信号

);

endmodule
