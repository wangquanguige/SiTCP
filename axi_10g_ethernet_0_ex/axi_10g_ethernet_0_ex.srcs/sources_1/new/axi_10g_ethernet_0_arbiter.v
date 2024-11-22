`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/24 17:20:37
// Design Name: 
// Module Name: axi_10g_ethernet_0_arbiter
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


module axi_10g_ethernet_0_arbiter #(
    parameter       BOARD_MAC       =   48'h00_11_22_33_44_55       ,
    parameter       BOARD_IP        =   {8'd192,8'd168,8'd1,8'd10}
)
(
    input                        aclk,
    input                        areset,

    // ARP REPLY
    input           [15:0]       optype,
    input           [63:0]       arp_head,
    input           [47:0]       arp_src_mac,
    input           [31:0]       arp_src_ip,  
    input                        arp_reply_en,

    // ICMP REPLY
    input           [31:0]       icmp_src_ip,
    input           [63:0]       icmp_data_0,
    input           [63:0]       icmp_data_1,
    input           [63:0]       icmp_data_2,
    input           [63:0]       icmp_data_3,
    input           [15:0]       icmp_identification,
    input           [15:0]       icmp_sequence_number,
    input                        icmp_reply_en,

    // ARP ADDR MAP
    input           [47:0]       rx_arp_mac,
    input           [31:0]       rx_arp_ip,
    input                        rx_arp_en,

    // TCP TX
    input           [63:0]       tcp_tx_axis_tdata,
    input           [7:0]        tcp_tx_axis_tkeep,
    input                        tcp_tx_axis_tvalid,
    input                        tcp_tx_axis_tlast,
    input                        tcp_tx_axis_en,
    output                       tcp_tx_axis_tready
);

    wire arp_reply_tready;
    wire icmp_reply_tready;

    axi_10g_ethernet_0_arbiter_control arbiter_control (
        .tcp_tx_axis_en             (tcp_tx_axis_en),
        .arp_reply_en               (arp_reply_en),
        .icmp_reply_en              (icmp_reply_en),

        .tcp_tx_axis_tready         (tcp_tx_axis_tready),
        .arp_reply_tready           (arp_reply_tready),
        .icmp_reply_tready          (icmp_reply_tready)
    );

    axi_10g_ethernet_0_arp_reply arp_reply (

    );

    axi_10g_ethernet_0_icmp_reply icmp_reply (

    );

    axi_10g_ethernet_0_tcp_encap tcp_encap (

    );
endmodule
