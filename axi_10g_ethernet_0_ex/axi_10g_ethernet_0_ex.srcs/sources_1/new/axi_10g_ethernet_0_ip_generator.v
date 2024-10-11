`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 21:35:46
// Design Name: 
// Module Name: axi_10g_ethernet_0_ip_generator
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


module axi_10g_ethernet_0_ip_generator #(
    parameter       BOARD_MAC       =   48'h00_11_22_33_44_55       ,
    parameter       BOARD_IP        =   {8'd192,8'd168,8'd1,8'd10}
)
(
   input                  aclk,
   input                  areset,

   input       [15:0]      optype,
   input       [63:0]      arp_head,
   input       [47:0]      arp_dec_mac,
   input       [31:0]      arp_dec_ip,
   input                   arp_rx_done,

   output reg  [63:0]     tx_axis_tdata,
   output reg  [7:0]      tx_axis_tkeep,
   output reg             tx_axis_tlast,
   output reg             tx_axis_tvalid
);

localparam IDLE = 0,
           START_ARP = 1,
           START_ICMP = 2,
           OP   = 3,
           DATA1 = 4,
           DATA2 = 5,
           DATA3 = 6,
           DATA4 = 7,
           DATA5 = 8,
           DATA6 = 9;

reg [3:0] state;

reg [15:0] optype_reg;
reg [63:0] arp_head_reg;
reg [47:0] arp_dec_mac_reg;
reg [31:0] arp_dec_ip_reg; 

reg [47:0] icmp_dec_mac_reg;
reg [31:0] icmp_dec_ip_reg; 
reg [1:0]  icmp_cnt;

always @(posedge aclk) begin
    if (areset) begin
        optype_reg <= 0;
        arp_head_reg <= 0;
        arp_dec_mac_reg <= 0;
        arp_dec_ip_reg <= 0;
    end
    else if (arp_rx_done) begin
        optype_reg <= optype;
        arp_head_reg <= arp_head;
        arp_dec_mac_reg <= arp_dec_mac;
        arp_dec_ip_reg <= arp_dec_ip;
        state <= START_ARP;
    end
    else if (icmp_rx_done) begin
        icmp_dec_mac_reg <= arp_dec_mac;
        icmp_dec_ip_reg <= arp_dec_ip;
        state <= START_ICMP;
        icmp_cnt <= 0;
    end
end

always @(posedge aclk) begin
    if (areset) begin
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE : begin
                tx_axis_tdata <= 64'b0;
                tx_axis_tkeep <= 8'b0000_0000;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 0;
            end
            START_ARP : begin
                tx_axis_tdata <= {BOARD_MAC[39:32], BOARD_MAC[47:40], arp_dec_mac_reg};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= OP;
            end
            OP : begin
                tx_axis_tdata <= {arp_head_reg[15:0], optype_reg, BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA1;
            end
            DATA1 : begin
                tx_axis_tdata <= {BOARD_MAC[39:32], BOARD_MAC[47:40], 16'h02_00, arp_head_reg[47:16]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA2;
            end
            DATA2 : begin
                tx_axis_tdata <= {BOARD_IP[7:0], BOARD_IP[15:8], BOARD_IP[23:16], BOARD_IP[31:24], BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA3;
            end
            DATA3 : begin
                tx_axis_tdata <= {arp_dec_ip_reg[15:0], arp_dec_mac_reg};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA4;
            end
            DATA4 : begin
                tx_axis_tdata <= {48'b0, arp_dec_ip_reg[31:16]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA5;
            end
            DATA5 : begin
                tx_axis_tdata <= 64'b0;
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA6;
            end
            DATA6 : begin
                tx_axis_tdata <= 64'b0;
                tx_axis_tkeep <= 8'b0000_1111;
                tx_axis_tlast <= 1;
                tx_axis_tvalid <= 1;
                state <= IDLE;
            end
            START_ICMP : begin
                if (icmp_cnt == 0) begin
                    tx_axis_tdata <= 64'b0;
                    tx_axis_tkeep <= 8'b0000_0000;
                    tx_axis_tlast <= 0;
                    tx_axis_tvalid <= 0;
                end
            end
        endcase
    end
end

endmodule
