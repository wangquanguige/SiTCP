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

// 可能会有发送冲突，这个还没考虑
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

   input       [31:0]      icmp_dec_ip,
   input       [63:0]      icmp_data_0,
   input       [63:0]      icmp_data_1,
   input       [63:0]      icmp_data_2,
   input       [63:0]      icmp_data_3,
   input       [15:0]      icmp_identification,
   input       [15:0]      icmp_sequence_number,
   input                   icmp_rx_done,

   output reg  [63:0]     tx_axis_tdata,
   output reg  [7:0]      tx_axis_tkeep,
   output reg             tx_axis_tlast,
   output reg             tx_axis_tvalid,

   input                    tx_arp,
   input        [31:0]      tx_arp_ip
);

integer i;
integer j;

localparam IDLE = 0,
           START_ARP = 1,
           START_ICMP = 2,
           DATA1 = 3,
           DATA2 = 4,
           DATA3 = 5,
           DATA4 = 6,
           DATA5 = 7,
           CAL_HEADER_CHECKSUM = 8,
           CAL_ICMP_HEADER_CHECKSUM = 9,
           ICMP_TX = 10;

localparam START_ARP_REQUEST = 1;


localparam IP_VERSION = 16'h0004,
           IP_HEADER_LEGTH = 16'h0005,
           IP_TYPE_SERVICE = 8'b0,
           IP_FLAGS_OFFSET = 16'b0,
           IP_TTL_PROTOCOL = 16'h8001;

reg [15:0] ip_head [9:0];
reg [31:0] ip_head_sum;

reg [15:0] icmp_head[3:0];
reg [63:0] icmp_data_reg[3:0];
reg [31:0] icmp_head_sum;


reg [3:0] state;
reg [1:0] arp_request_state;

reg [15:0] optype_reg;
reg [63:0] arp_head_reg;
reg [47:0] arp_dec_mac_reg;
reg [31:0] arp_dec_ip_reg; 

reg [47:0] icmp_dec_mac_reg;
reg [31:0] icmp_dec_ip_reg; 
reg [2:0]  icmp_cnt;

reg [31:0] tx_arp_ip_reg;
reg [2:0] tx_arp_cnt;

/*function automatic [N-1:0] swap_endian;
    input [N-1:0] value;
    integer i;
    reg [N-1:0] reversed_value;
    begin
        reversed_value = 'b0;
        for (i = 0; i < N; i = i + 8) begin
            reversed_value[i +: 8] = value[N - i - 1 -: 8];
        end
        swap_endian = reversed_value;
    end
endfunction*/
function automatic [16-1:0] swap_endian_16;
    input reg [16-1:0] value;
    integer i;
    reg [16-1:0] swapped_value;
    begin
        swapped_value = 'b0; // 初始化反转后的位向量
        for (i = 0; i < 16/8; i = i + 1) begin
            // 每次处理8位（1字节），将字节从大端转换为小端
            swapped_value[i*8 +: 8] = value[(16 - i*8 - 1) -: 8];
        end
        swap_endian_16 = swapped_value;
    end
endfunction

function automatic [32-1:0] swap_endian_32;
    input reg [32-1:0] value;
    integer i;
    reg [32-1:0] swapped_value;
    begin
        swapped_value = 'b0; // 初始化反转后的位向量
        for (i = 0; i < 32/8; i = i + 1) begin
            // 每次处理8位（1字节），将字节从大端转换为小端
            swapped_value[i*8 +: 8] = value[(32 - i*8 - 1) -: 8];
        end
        swap_endian_32 = swapped_value;
    end
endfunction

function automatic [48-1:0] swap_endian_48;
    input reg [48-1:0] value;
    integer i;
    reg [48-1:0] swapped_value;
    begin
        swapped_value = 'b0; // 初始化反转后的位向量
        for (i = 0; i < 48/8; i = i + 1) begin
            // 每次处理8位（1字节），将字节从大端转换为小端
            swapped_value[i*8 +: 8] = value[(48 - i*8 - 1) -: 8];
        end
        swap_endian_48 = swapped_value;
    end
endfunction

function automatic [64-1:0] swap_endian_64;
    input reg [64-1:0] value;
    integer i;
    reg [64-1:0] swapped_value;
    begin
        swapped_value = 'b0; // 初始化反转后的位向量
        for (i = 0; i < 64/8; i = i + 1) begin
            // 每次处理8位（1字节），将字节从大端转换为小端
            swapped_value[i*8 +: 8] = value[(64 - i*8 - 1) -: 8];
        end
        swap_endian_64 = swapped_value;
    end
endfunction

always @(posedge aclk) begin
    if (areset) begin
        $display("real have reset?");
        optype_reg <= 0;
        arp_head_reg <= 0;
        arp_dec_mac_reg <= 0;
        arp_dec_ip_reg <= 0;
        tx_arp_cnt <= 0;
    end
    else if (arp_rx_done) begin
        optype_reg <= optype;
        arp_head_reg <= arp_head;
        arp_dec_mac_reg <= arp_dec_mac;
        arp_dec_ip_reg <= arp_dec_ip;
        state <= START_ARP;
    end
    else if (icmp_rx_done) begin
        icmp_dec_ip_reg <= icmp_dec_ip;
        icmp_data_reg[0] <= icmp_data_0;
        icmp_data_reg[1] <= icmp_data_1;
        icmp_data_reg[2] <= icmp_data_2;
        icmp_data_reg[3] <= icmp_data_3;
        state <= START_ICMP;
        icmp_cnt <= 0;
        ip_head_sum <= 0;
        icmp_head_sum <= 0;
    end
end

always @(posedge aclk) begin
    if (tx_arp) begin
        tx_arp_ip_reg <= tx_arp_ip;
        arp_request_state <= START_ARP_REQUEST;
        tx_arp_cnt <= 0;
    end
    else begin
        case (arp_request_state)
            IDLE : begin
                tx_axis_tdata <= 64'b0;
                tx_axis_tkeep <= 8'b0000_0000;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 0;
            end
            START_ARP_REQUEST : begin
                case (tx_arp_cnt)
                    3'h0 : begin
                        tx_axis_tdata <= {8'h04, 8'h06, 16'h0008, 16'h0100, 16'h0608};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= tx_arp_cnt + 1;
                        $display("arp00");
                    end
                    3'h1 : begin
                        tx_axis_tdata <= {BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24], BOARD_MAC[39:32], BOARD_MAC[47:40], 16'h01_00};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= tx_arp_cnt + 1;
                        $display("arp11");
                    end
                    3'h2 : begin
                        tx_axis_tdata <= {32'b0, BOARD_IP[7:0], BOARD_IP[15:8], BOARD_IP[23:16], BOARD_IP[31:24]};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= tx_arp_cnt + 1;
                        $display("arp22");
                    end
                    3'h3 : begin
                        tx_axis_tdata <= {16'b0, tx_arp_ip_reg[31:0], 16'b0};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= tx_arp_cnt + 1;
                        $display("arp33");
                    end
                    3'h4 : begin
                        tx_axis_tdata <= 64'b0;
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= tx_arp_cnt + 1;
                        $display("arp44");
                    end
                    3'h5 : begin
                        tx_axis_tdata <= 64'b0;
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        tx_arp_cnt <= 0;
                        arp_request_state <= IDLE;
                        $display("arp55");
                    end
                endcase
            end
        endcase
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
                tx_axis_tdata <= {arp_head_reg[47:0], optype_reg};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA1;
                $display("arp00");
            end
            DATA1 : begin
                tx_axis_tdata <= {BOARD_MAC[7:0], BOARD_MAC[15:8], BOARD_MAC[23:16], BOARD_MAC[31:24], BOARD_MAC[39:32], BOARD_MAC[47:40], 16'h02_00};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA2;
                $display("arp11");
            end
            DATA2 : begin
                tx_axis_tdata <= {arp_dec_mac_reg[31:0], BOARD_IP[7:0], BOARD_IP[15:8], BOARD_IP[23:16], BOARD_IP[31:24]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA3;
                $display("arp22");
            end
            DATA3 : begin
                tx_axis_tdata <= {16'b0, arp_dec_ip_reg[31:0], arp_dec_mac_reg[47:32]};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA4;
                $display("arp033");
            end
            DATA4 : begin
                tx_axis_tdata <= {64'b0};
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
                state <= DATA5;
            end
            DATA5 : begin
                tx_axis_tdata <= 64'b0;
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 1;
                tx_axis_tvalid <= 1;
                state <= IDLE;
            end
            START_ICMP : begin
                ip_head[0] <= {IP_VERSION, IP_HEADER_LEGTH, IP_TYPE_SERVICE};
                ip_head[1] <= 16'h003C;
                ip_head[2] <= swap_endian_16(icmp_identification);
                ip_head[3] <= IP_FLAGS_OFFSET;
                ip_head[4] <= IP_TTL_PROTOCOL;
                ip_head[5] <= 16'b0;
                ip_head[6] <= BOARD_IP[31:16];
                ip_head[7] <= BOARD_IP[15:0];
                ip_head[8] <= swap_endian_16(icmp_dec_ip_reg[15:0]);
                ip_head[9] <= swap_endian_16(icmp_dec_ip_reg[31:16]);
                state <= CAL_HEADER_CHECKSUM;
                $display("1");
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

                for (i = 0; i < 16; i = i + 1) begin
                    ip_head_sum[i] = 1- ip_head_sum[i];
                end

                ip_head[5] = ip_head_sum[15:0];

                icmp_head[0] <= 16'b0;
                icmp_head[1] <= 16'b0;
                icmp_head[2] <= 16'h00_01;
                icmp_head[3] <= swap_endian_16(icmp_sequence_number);

                state <= CAL_ICMP_HEADER_CHECKSUM;
                $display("2");
            end
            CAL_ICMP_HEADER_CHECKSUM : begin
                icmp_head_sum = icmp_head_sum + icmp_head[0];
                icmp_head_sum = icmp_head_sum + icmp_head[1];
                icmp_head_sum = icmp_head_sum + icmp_head[2];
                icmp_head_sum = icmp_head_sum + icmp_head[3];

                for (i = 0; i < 4; i = i + 1) begin
                    for (j = 0; j < 64; j = j + 16) begin
                        icmp_head_sum = icmp_head_sum + icmp_data_reg[i][j+ : 16];
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
                $display("3");
            end
            ICMP_TX : begin
                $display("4");
                case (icmp_cnt)
                    3'h0 : begin
                        tx_axis_tdata <= {swap_endian_16(ip_head[2]), 48'h3C0000450008};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 1;
                    end
                    3'h1 : begin
                        tx_axis_tdata <= {swap_endian_16(ip_head[6]), swap_endian_16(ip_head[5]), swap_endian_16(ip_head[4]), swap_endian_16(ip_head[3])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 2;
                    end
                    3'h2 : begin
                        tx_axis_tdata <= {swap_endian_16(icmp_head[0]), swap_endian_16(ip_head[9]), swap_endian_16(ip_head[8]), swap_endian_16(ip_head[7])};
                        //tx_axis_tdata <= {swap_endian_48(icmp_data_reg[0][47:0]), swap_endian_16(icmp_head[3]), swap_endian_16(icmp_head[2])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 3;
                    end
                    3'h3 : begin
                        tx_axis_tdata <= {swap_endian_16(icmp_data_reg[0][15:0]), swap_endian_16(icmp_head[3]), swap_endian_16(icmp_head[2]), swap_endian_16(icmp_head[1])};
                        //tx_axis_tdata <= {swap_endian_48(icmp_data_reg[1][47:0]), swap_endian_16(icmp_data_reg[0][63:48])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 4;
                    end
                    3'h4 : begin
                        tx_axis_tdata <= {swap_endian_16(icmp_data_reg[1][15:0]), swap_endian_48(icmp_data_reg[0][63:16])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 5;
                    end
                    3'h5 : begin
                        tx_axis_tdata <= {swap_endian_16(icmp_data_reg[2][15:0]), swap_endian_48(icmp_data_reg[1][63:16])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 6;
                    end
                    3'h6 : begin
                        tx_axis_tdata <= {swap_endian_16(icmp_data_reg[3][15:0]), swap_endian_48(icmp_data_reg[2][63:16])};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 7;
                    end
                    3'h7 : begin
                        tx_axis_tdata <= {16'b0, swap_endian_48(icmp_data_reg[3][63:16])};
                        tx_axis_tkeep <= 8'b00011_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        icmp_cnt <= 0;
                        state <= IDLE;
                    end
                endcase
            end
        endcase
    end
end

endmodule
