`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 17:29:51
// Design Name: 
// Module Name: axi_10g_ethernet_0_icmp_reply
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


module axi_10g_ethernet_0_icmp_reply #(
    parameter                       show_output_block           =           1           
)
(
    input                           aclk                ,          
    input                           areset              ,       

    input                           tx_icmp_en          ,
    input               [47:0]      icmp_src_mac        ,
    input               [31:0]      icmp_src_ip         ,

    output      reg     [63:0]      tx_axis_tdata       ,
    output      reg     [ 7:0]      tx_axis_tkeep       ,
    output      reg                 tx_axis_tvalid      ,
    output      reg                 tx_axis_tlast       ,

    input                           icmp_reply_tready   ,
    output      reg                 icmp_reply_en       ,
    output      reg                 icmp_reply_done
);
/*
localparam IDLE             =       0,
           MAC_HEAD         =       1,
           IP_HEAD          =       2,
           IP_HEAD_SRC_IP   =       3,
           ICMP_HEAD        =       4,
           DATA             =       5;

reg         [47:0]          icmp_src_mac_reg             ;
reg         [31:0]          icmp_src_ip_reg              ;

reg         [ 3:0]          state       ;

always @(posedge aclk) begin
    if (areset) begin
        arp_src_mac_reg             <=          0                       ;
        arp_src_ip_reg              <=          0                       ;
    end
    else begin
        if (tx_arp_en) begin
            arp_src_mac_reg             <=          arp_src_mac             ;
            arp_src_ip_reg              <=          arp_src_ip              ;
        end
    end
end

always @(posedge aclk) begin
    if (areset) begin
        state                       <=          IDLE                    ;
        arp_reply_en                <=          0                       ;

    end 
    if (tx_arp_en == 1) begin
        arp_reply_en                <=          1                       ;
    end
end

always @(posedge aclk) begin
    if (arp_reply_tready == 1) begin
        arp_reply_en                <=          0                       ;

        case (state)
            IDLE : begin
                tx_axis_tdata           <=          {BOARD_MAC[39:32],   BOARD_MAC[47:40],    arp_src_mac_reg}         ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          ARP_HEAD                                                        ;
            end 
            ARP_HEAD : begin
                tx_axis_tdata           <=          {8'h01, 8'h00, 8'h06, 8'h08, BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24]}    ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          OP                                                              ;
            end
            OP : begin
                tx_axis_tdata           <=          {BOARD_MAC[39:32], BOARD_MAC[47:40], 8'h02, 8'h00, 8'h04, 8'h06, 8'h00, 8'h08}    ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          MAC_IP                                                          ;
            end
            MAC_IP : begin
                tx_axis_tdata           <=          {BOARD_IP[7:0], BOARD_IP[15:8], BOARD_IP[23:16], BOARD_IP[31:24], BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24]}    ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          DES_MAC                                                         ;
            end
            DES_MAC : begin
                tx_axis_tdata           <=          {arp_src_ip_reg[15:0],  arp_src_mac_reg}                        ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          DES_IP                                                          ;
            end
            DES_IP : begin
                tx_axis_tdata           <=          {48'b0,     arp_src_ip_reg[31:16]}                              ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          PAD_ONE                                                         ;
            end
            PAD_ONE : begin
                tx_axis_tdata           <=          64'b0                                                           ;
                tx_axis_tkeep           <=          8'b1111_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          0                                                               ;

                state                   <=          PAD_TWO                                                         ;
            end
            PAD_TWO : begin
                tx_axis_tdata           <=          64'b0                                                           ;
                tx_axis_tkeep           <=          8'b0000_1111                                                    ;
                tx_axis_tvalid          <=          1                                                               ;
                tx_axis_tlast           <=          1                                                               ;

                state                   <=          IDLE                                                            ;
                arp_reply_done          <=          1                                                               ;
            end
        endcase
    end
    else begin
        arp_reply_done          <=          0           ;
    end
end
*/
endmodule
