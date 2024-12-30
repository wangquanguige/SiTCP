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


module axi_10g_ethernet_0_arp_block(
   input wire  [47:0]                  dest_addr                ,
   input wire  [47:0]                  src_addr                 ,

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

   input       [31:0]                  arp_request_ip           ,
   input                               tx_tcp_en                ,
   output                              tc_tcp_tready
);

wire                            arp_reply_tready        ;
wire                            arp_reply_en            ;
wire                            arp_rx_type             ;
wire            [47:0]          arp_src_mac             ;
wire            [31:0]          arp_src_ip              ;

axi_10g_ethernet_0_arp_parser (
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .rx_axis_tdata                   (rx_axis_tdata)            ,
    .rx_axis_tkeep                   (rx_axis_tkeep)            ,
    .rx_axis_tvalid                  (rx_axis_tvalid)           ,
    .rx_axis_tlast                   (rx_axis_tlast)            ,
    .rx_axis_tready                  (rx_axis_tready)           ,

    .arp_reply_en                    (arp_reply_en)             ,
    .arp_rx_type                     (arp_rx_type)              ,
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)
);

axi_10g_ethernet_0_arp_generator (
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .arp_reply_en                    (arp_reply_en)             ,
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
    .tx_tcp_tready                   (tx_tcp_tready)                    // tcp允许发送报文
);

endmodule
