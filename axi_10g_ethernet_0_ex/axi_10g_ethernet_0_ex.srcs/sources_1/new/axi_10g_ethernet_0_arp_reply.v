`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 17:29:34
// Design Name: 
// Module Name: axi_10g_ethernet_0_arp_reply
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


module axi_10g_ethernet_0_arp_reply(
    input                               aclk                    ,
    input                               areset                  ,

    input                               tx_arp_en               ,
    input                               arp_rx_type             ,
    input       [47:0]                  arp_src_mac             ,
    input       [31:0]                  arp_src_ip              ,

    output      [63:0]                  tx_axis_tdata           ,
    output      [7:0]                   tx_axis_tkeep           ,
    output                              tx_axis_tvalid          ,
    output                              tx_axis_tlast           ,
    input                               tx_axis_tready          ,

    input                               arp_reply_tready
);

reg         [47:0]          mac_list            [10:0]          ;
reg         [31:0]          ip_list             [10:0]          ;

reg                         arp_reply_en_reg            ;
reg                         arp_rx_type_reg             ;
reg         [47:0]          arp_src_mac_reg             ;
reg         [31:0]          arp_src_ip_reg              ;

always @(posedge aclk) begin
    if (areset) begin
        arp_reply_en_reg            <=          0                       ;
        arp_rx_type_reg             <=          0                       ;
        arp_src_mac_reg             <=          0                       ;
        arp_src_ip_reg              <=          0                       ;
    end
    else begin
        arp_reply_en_reg            <=          arp_reply_en            ;
        arp_rx_type_reg             <=          arp_rx_type             ;
        arp_src_mac_reg             <=          arp_src_mac             ;
        arp_src_ip_reg              <=          arp_src_ip              ;
    end
end

always @(posedge aclk) begin
    if (arp_reply_tready) begin
        state
    end
end

endmodule
