`timescale 1ps / 1ps
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

   input       [63:0]      icmp_data[3:0],

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
           DATA6 = 9,
           CAL_HEADER_CHECKSUM = 10,
           CAL_ICMP_HEADER_CHECKSUM = 11,
           ICMP_TX = 12;

localparam IP_VERSION = 4'b0004,
           IP_HEADER_LEGTH = 4'b0005,
           IP_TYPE_SERVICE = 8'b0,
           IP_FLAGS_OFFSET = 16'b0,
           IP_TTL_PROTOCOL = 16'h8001;

reg [15:0] IP_Identification;

reg [15:0] ip_head [9:0];
reg [31:0] ip_head_sum;

reg [15:0] icmp_head[3:0];
reg [63:0] icmp_data_reg[3:0];
reg [31:0] icmp_head_sum;


reg [3:0] state;

reg [15:0] optype_reg;
reg [63:0] arp_head_reg;
reg [47:0] arp_dec_mac_reg;
reg [31:0] arp_dec_ip_reg; 

reg [47:0] icmp_dec_mac_reg;
reg [31:0] icmp_dec_ip_reg; 
reg [1:0]  icmp_cnt;

function automatic reg [N-1:0] swap_endian;
    input reg [N-1:0] value;
    integer i;
    reg [N-1:0] reversed_value;
    begin
        reversed_value = 'b0;
        for (i = 0; i < N; i = i + 8) begin
            reversed_value[i +: 8] = value[N - i - 1 -: 8];
        end
        swap_endian = reversed_value;
    end
endfunction

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
        icmp_data_reg <= icmp_data;
        state <= START_ICMP;
        icmp_cnt <= 0;
        ip_head_sum <= 0;
        icmp_head_sum <= 0;
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
                ip_head[0] <= {IP_VERSION, IP_HEADER_LEGTH, IP_TYPE_SERVICE};
                ip_head[1] <= icmp_total_length_reg;
                ip_head[2] <= IP_Identification;
                IP_Identification <= IP_Identification + 1;
                ip_head[3] <= IP_FLAGS_OFFSET;
                ip_head[4] <= IP_TTL_PROTOCOL;
                ip_head[5] <= 16'b0;
                ip_head[6] <= BOARD_IP[31:16];
                ip_head[7] <= BOARD_IP[15:0];
                ip_head[8] <= swap_endian(icmp_dec_ip_reg)[31:16];
                ip_head[9] <= swap_endian(icmp_dec_ip_reg)[15:0];
                state <= CAL_HEADER_CHECKSUM;
            end
            CAL_HEADER_CHECKSUM : begin
                ip_head_sum = ip_head_sum + ip_head[0];
                ip_head_sum = ip_head_sum + ip_head[1];
                ip_head_sum = ip_head_sum + ip_head[2];
                ip_head_sum = ip_head_sum + ip_head[3];
                ip_head_sum = ip_head_sum + ip_head[4];
                ip_head_sum = ip_head_sum + ip_head[5];
                ip_head_sum = ip_head_sum + ip_head[6];
                ip_head_sum = ip_head_sum + ip_head[7];
                ip_head_sum = ip_head_sum + ip_head[8];
                ip_head_sum = ip_head_sum + ip_head[9];

                ip_head_sum = ip_head_sum[31:16] + ip_head_sum[15:0];
                ip_head_sum = ip_head_sum[31:16] + ip_head_sum[15:0];
                ip_head_sum = ip_head_sum[31:16] + ip_head_sum[15:0];

                for (integer i = 0; i < 16; i = i + 1) begin
                    ip_head_sum[i] = 1- ip_head_sum[i];
                end

                ip_head[5] = ip_head_sum[15:0];

                icmp_head[0] <= 16'b0;
                icmp_head[1] <= 16'b0;
                icmp_head[2] <= 16'h00_01;
                icmp_head[3] <= icmp_head[3] + 1;

                state <= CAL_ICMP_HEADER_CHECKSUM;
            end
            CAL_ICMP_HEADER_CHECKSUM : begin
                icmp_head_sum = icmp_head_sum + icmp_head[0];
                icmp_head_sum = icmp_head_sum + icmp_head[1];
                icmp_head_sum = icmp_head_sum + icmp_head[2];
                icmp_head_sum = icmp_head_sum + icmp_head[3];

                for (integer i = 0; i < 4; i = i + 1) begin
                    for (integer j = 0; j < 64; j = j + 16) begin
                        icmp_head_sum = icmp_head_sum + icmp_data_reg[i][j + 15 : j];
                    end
                end
                
                icmp_head_sum = icmp_head_sum[31:16] + icmp_head_sum[15:0];
                icmp_head_sum = icmp_head_sum[31:16] + icmp_head_sum[15:0];
                icmp_head_sum = icmp_head_sum[31:16] + icmp_head_sum[15:0];

                for (integer i = 0; i < 16; i = i + 1) begin
                    icmp_head_sum[i] = 1 - icmp_head_sum[i];
                end

                icmp_head[1] = icmp_head_sum[15:0];

                state <= ICMP_TX;
                icmp_cnt <= 0;
            end
            ICMP_TX : begin
                case (icmp_cnt)
                    0 : begin
                        tx_axis_tdata <= {swap_endian(icmp_head[3]), 48'b3C0000450008};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                    end
                endcase
            end
        endcase
    end
end

endmodule
