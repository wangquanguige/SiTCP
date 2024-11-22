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
   input                               aclk,
   input                               aresetn,

   input       [47:0]                  rx_arp_mac,
   input       [31:0]                  rx_arp_ip,
   input                               rx_arp_en,

   input       [63:0]                  rx_axis_tdata,
   input       [7:0]                   rx_axis_tkeep,
   input                               rx_axis_tvalid,
   input                               rx_axis_tlast,

   input       [63:0]                  icmp_rx_axis_tdata,
   input       [7:0]                   icmp_rx_axis_tkeep,
   input                               icmp_rx_axis_tvalid,
   input                               icmp_rx_axis_tlast,

   input       [63:0]                  ip_rx_axis_tdata,
   input       [7:0]                   ip_rx_axis_tkeep,
   input                               ip_rx_axis_tvalid,
   input                               ip_rx_axis_tlast,

   output reg  [63:0]                  tx_axis_tdata,
   output reg  [7:0]                   tx_axis_tkeep,
   output reg                          tx_axis_tvalid,
   output reg                          tx_axis_tlast,

   output reg                          tcp_en,
   output reg                          arp_en,
   output reg                          icmp_en,

   output reg                          tx_arp,
   output reg  [31:0]                  tx_arp_ip
);

localparam IDLE = 0,
           RX_IP = 1,
           ADD_ADDR = 2,
           TX_ADDR = 3,
           TX_DATA = 4,
           TX_EXTRA = 5,
           GARBAGE_TIME = 6;


reg [47:0] mac_list[9:0];
reg [31:0] ip_list[9:0];
reg [3:0] list_head = 4'b0;
reg [3:0] list_tail = 4'b0;
reg [3:0] list_cnt = 4'd10;

reg [2:0] state;
reg [15:0] optype;
reg [31:0] des_ip;
reg [47:0] des_mac;
reg [2:0] rx_cnt;

reg ip_match;

reg [63:0] data_reg[5:0];
reg [7:0] keep_reg[5:0];
reg last_reg[5:0];

reg [31:0] extra_data;
reg [7:0] extra_keep;

integer i;

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

always @(posedge aclk) begin
    if (aresetn) begin
        state <= IDLE;
        list_head <= 0;
        list_tail <= 0;
        list_cnt <= 4'd10;
        rx_cnt <= 0;
        ip_match <= 0;
        tx_arp <= 0;
        extra_data <= 0;
        extra_keep <= 0;
    end
end

always @(posedge aclk) begin
    if (rx_arp_en) begin
        ip_list[list_tail] <= rx_arp_ip;
        mac_list[list_tail] <= rx_arp_mac;

        $display("ip %h, mac %h", rx_arp_ip, rx_arp_mac);

        if ((list_tail + 1) % (list_cnt + 1) != list_head) begin
            list_tail = (list_tail + 1) % (list_cnt + 1);
        end
        else begin
            list_tail = (list_tail + 1) % (list_cnt + 1);
            list_head = (list_head + 1) % (list_cnt + 1);
        end
    end
end

always @(posedge aclk) begin
    data_reg[5] <= data_reg[4];
    data_reg[4] <= data_reg[3];
    data_reg[3] <= data_reg[2];
    data_reg[2] <= data_reg[1];
    data_reg[1] <= data_reg[0];
    data_reg[0] <= rx_axis_tdata;

    keep_reg[5] <= keep_reg[4];
    keep_reg[4] <= keep_reg[3];
    keep_reg[3] <= keep_reg[2];
    keep_reg[2] <= keep_reg[1];
    keep_reg[1] <= keep_reg[0];
    keep_reg[0] <= rx_axis_tkeep;

    last_reg[5] <= last_reg[4];
    last_reg[4] <= last_reg[3];
    last_reg[3] <= last_reg[2];
    last_reg[2] <= last_reg[1];
    last_reg[1] <= last_reg[0];
    last_reg[0] <= rx_axis_tlast;
end

always @(posedge aclk) begin
    case (state)
        IDLE : begin
            tx_axis_tdata <= 64'b0;
            tx_axis_tkeep <= 8'b0000_0000;
            tx_axis_tlast <= 0;
            tx_axis_tvalid <= 0;
            ip_match <= 0;

            if (rx_axis_tvalid) begin
                optype <= rx_axis_tdata[15:0];
                state <= RX_IP;
            end
        end
        RX_IP : begin
            $display("00");
            case (rx_cnt)
                0 : begin
                    rx_cnt <= 1;
                end
                1 : begin
                    rx_cnt <= 2;
                end
                2 : begin
                    rx_cnt <= 0;
                    state <= ADD_ADDR;
                end
            endcase
        end
        ADD_ADDR : begin
            $display("11");
            if (optype == 16'h0608) begin
                des_ip = data_reg[0][47:16];
            end
            else begin
                des_ip = data_reg[1][47:16];
            end

            $display("desp_ip: %h", des_ip);

            i = list_head;
            while (i != list_tail) begin
                if (ip_list[i] == des_ip) begin
                    des_mac = mac_list[i];
                    ip_match = 1;
                    
                end
                i = (i + 1) % (list_cnt + 1);
            end

            if (ip_match == 1) begin
                state <= TX_ADDR;
            end
            else begin
                state <= GARBAGE_TIME;
                tx_arp <= 1;
                tx_arp_ip <= des_ip;
            end
        end
        TX_ADDR : begin
            $display("22");
            tx_axis_tdata <= {swap_endian_16(BOARD_MAC[47:32]), des_mac};
            tx_axis_tkeep <= 8'b1111_1111;
            tx_axis_tlast <= 0;
            tx_axis_tvalid <= 1;
            extra_data <= swap_endian_32(BOARD_MAC[31:0]);
            state <= TX_DATA;
        end
        TX_DATA : begin
            $display("33");
            if (last_reg[5] != 1) begin
                tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                extra_data <= data_reg[5][63:32];
                tx_axis_tkeep <= 8'b1111_1111;
                tx_axis_tlast <= 0;
                tx_axis_tvalid <= 1;
            end
            else begin
                case (keep_reg[5]) 
                    8'b1111_1111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        extra_data <= data_reg[5][63:32];
                        extra_keep <= 8'b0000_1111;
                        state <= TX_EXTRA;
                    end
                    8'b0111_1111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        extra_data <= data_reg[5][63:32];
                        extra_keep <= 8'b0000_0111;
                        state <= TX_EXTRA;
                    end
                    8'b0011_1111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        extra_data <= data_reg[5][63:32];
                        extra_keep <= 8'b0000_0011;
                        state <= TX_EXTRA;
                    end
                    8'b0001_1111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 0;
                        tx_axis_tvalid <= 1;
                        extra_data <= data_reg[5][63:32];
                        extra_keep <= 8'b0000_0001;
                        state <= TX_EXTRA;
                    end
                    8'b0000_1111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b1111_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        extra_data <= 0;
                        extra_keep <= 0;
                        state <= IDLE;
                    end
                    8'b0000_0111 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b0111_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        extra_data <= 0;
                        extra_keep <= 0;
                        state <= IDLE;
                    end
                    8'b0000_0011 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b0011_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        extra_data <= 0;
                        extra_keep <= 0;
                        state <= IDLE;
                    end
                    8'b0000_0001 : begin
                        tx_axis_tdata <= {data_reg[5][31:0], extra_data};
                        tx_axis_tkeep <= 8'b0001_1111;
                        tx_axis_tlast <= 1;
                        tx_axis_tvalid <= 1;
                        extra_data <= 0;
                        extra_keep <= 0;
                        state <= IDLE;
                    end
                endcase
            end
        end
        TX_EXTRA : begin
            $display("44");
            tx_axis_tdata <= extra_data;
            tx_axis_tkeep <= extra_keep;
            tx_axis_tlast <= 1;
            tx_axis_tvalid <= 1;
            extra_data <= 0;
            extra_keep <= 0;
            state <= IDLE;
        end
        GARBAGE_TIME : begin
            tx_arp <= 0;
            if (last_reg[5] == 1) begin
                state <= IDLE;
            end
        end
    endcase
end

endmodule
