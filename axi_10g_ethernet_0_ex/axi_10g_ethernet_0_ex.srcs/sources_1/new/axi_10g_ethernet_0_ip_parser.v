`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 18:55:06
// Design Name: 
// Module Name: axi_10g_ethernet_0_ip_parser
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


module axi_10g_ethernet_0_ip_parser #(
    parameter       BOARD_MAC       =   48'h00_11_22_33_44_55       ,
    parameter       BOARD_IP        =   {8'd192,8'd168,8'd1,8'd10}
)
(
    input                   aclk,
    input                   areset,

   input                   mux_select,

   // mux inputs
   input       [63:0]      tdata0,
   input       [7:0]       tkeep0,
   input                   tvalid0,
   input                   tlast0,
   output reg              tready0,

   input       [63:0]      tdata1,
   input       [7:0]       tkeep1,
   input                   tvalid1,
   input                   tlast1,
   output reg              tready1,

   // mux outputs
   output reg  [63:0]      tdata,
   output reg  [7:0]       tkeep,
   output reg              tvalid,
   output reg              tlast,
   input                   tready,

   output reg  [15:0]      optype,
   output reg  [63:0]      arp_head,
   output reg  [47:0]      arp_src_mac,
   output reg  [31:0]      arp_src_ip,

   output reg  [47:0]      icmp_src_mac,
   output reg  [31:0]      icmp_src_ip,

   output reg              arp_rx_done,
   output reg              icmp_rx_done
);

localparam IDLE = 0,
           OP   = 1,
           DATA1 = 2,
           DATA2 = 3,
           DATA3 = 4,
           DATA4 = 5,
           DATA5 = 6;

reg [2:0] state;

reg [47:0] des_mac;
reg [31:0] des_ip;
reg [31:0] des_ip_icmp;

reg [7:0] icmp_pro;

/*reg [15:0] optype;
reg [63:0] arp_head;
reg [47:0] arp_src_mac;
reg [31:0] arp_src_ip;*/

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
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= OP;
                    icmp_src_mac[15:0] <= tdata1[63:48];
                    $display("1optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            OP : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= DATA1;
                    optype <= tdata1[47:32];
                    arp_head[15:0] <= tdata1[63:48];
                    icmp_src_mac[47:16] <= tdata1[31:0];
                    $display("2optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            DATA1 : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= DATA2;
                    icmp_pro <= tdata1[63:56];
                    arp_head[63:16] <= tdata1[47:0];
                    arp_src_mac[15:0] <= tdata1[63:48];
                    $display("3optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            DATA2 : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= DATA3;
                    arp_src_mac[47:16] <= tdata1[31:0];
                    arp_src_ip <= tdata1[63:32];
                    des_ip_icmp[15:0] <= tdata1[63:48];
                    icmp_src_ip <= tdata1[47:16];
                    $display("4optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            DATA3 : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= DATA4;
                    des_mac <= tdata1[47:0];
                    des_ip[15:0] <= tdata1[63:48];
                    des_ip_icmp[31:16] <= tdata1[15:0];
                    $display("5optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            DATA4 : begin
                if (tkeep1 != 0 & tvalid1) begin
                    state <= DATA5;
                    des_ip[31:16] <= tdata1[15:0];
                    $display("6optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
            DATA5 : begin
                if (tkeep1 != 0 & tvalid1 & tlast1) begin
                    state <= IDLE;
                    $display("7optyte: %h, data: %h, state %h", optype, tdata1, state);
                end
            end
        endcase
    end
end

always @(posedge aclk) begin
    if (areset) begin
        arp_rx_done <= 0;
        icmp_rx_done <= 0;
    end
    else begin
        if (state == DATA5 & tkeep1 != 0 & tvalid1 & tlast1 & optype == 16'h0608 & swap_endian(des_ip) == BOARD_IP & (swap_endian(des_mac) == BOARD_MAC | swap_endian(des_mac) == 48'hff_ff_ff_ff_ff_ff)) begin
            arp_rx_done <= 1;
        end
        else if (state == DATA5 & tkeep1 != 0 & tvalid1 & tlast1 & optype == 16'h0008 & icmp_pro == 8'h01 & swap_endian(des_ip_icmp) == BOARD_IP) begin
            icmp_rx_done <= 1;
        end
        else begin
            arp_rx_done <= 0;
            icmp_rx_done <= 0;
        end
    end
end

/*always @(mux_select or tdata0 or tvalid0 or tlast0 or tdata1 or tkeep0 or tkeep1 or
         tvalid1 or tlast1)
begin
   if (mux_select) begin
      tdata    = tdata1;
      tkeep    = tkeep1;
      tvalid   = tvalid1;
      tlast    = tlast1;
   end
   else begin
      tdata    = tdata0;
      tkeep    = tkeep0;
      tvalid   = tvalid0;
      tlast    = tlast0;
   end
end

always @(mux_select or tready)
begin
   if (mux_select) begin
      tready0  = 1'b1 ;
      tready1  = tready;
   end
   else begin
      tready0  = tready;
      tready1  = 1'b1 ;
   end
end*/

endmodule
