`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/26 17:21:22
// Design Name: 
// Module Name: axi_10g_ethernet_0_deliver
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


module axi_10g_ethernet_0_deliver(
   input wire                          aclk,
   input wire                          areset,

   // data from the RX data path
   input       [63:0]                  rx_axis_tdata,
   input       [7:0]                   rx_axis_tkeep,
   input                               rx_axis_tvalid,
   input                               rx_axis_tlast,
   output                              rx_axis_tready,

   // data to the ARP data path
   output reg   [63:0]                 arp_rx_axis_tdata,
   output reg   [7:0]                  arp_rx_axis_tkeep,
   output reg                          arp_rx_axis_tvalid,
   output reg                          arp_rx_axis_tlast,
   input                               arp_rx_axis_tready,

   // data to the ICMP data path
   output reg  [63:0]                  icmp_rx_axis_tdata,
   output reg  [7:0]                   icmp_rx_axis_tkeep,
   output reg                          icmp_rx_axis_tvalid,
   output reg                          icmp_rx_axis_tlast,
   input                               icmp_rx_axis_tready,

   // data to the TCP data path
   output reg  [63:0]                  tcp_rx_axis_tdata,
   output reg  [7:0]                   tcp_rx_axis_tkeep,
   output reg                          tcp_rx_axis_tvalid,
   output reg                          tcp_rx_axis_tlast,
   input                               tcp_rx_axis_tready
);

localparam IDLE = 0,
           OP   = 1,
           DATA = 2;

reg [2:0]  state;
reg [15:0] optype;
reg        start_rx;

reg [63:0] tdata [0:1];
reg [7:0]  tkeep [0:1];
reg        tvalid[0:1];
reg        tlast [0:1];

always @(posedge aclk) begin
    if (areset) begin
        tdata [0] <= 0;
        tkeep [0] <= 0;
        tvalid[0] <= 0;
        tlast [0] <= 0;

        tdata [1] <= 1;
        tkeep [1] <= 1;
        tvalid[1] <= 1;
        tlast [1] <= 1;
    end
    else begin
        tdata [0] <= rx_axis_tdata;
        tkeep [0] <= rx_axis_tkeep;
        tvalid[0] <= rx_axis_tvalid;
        tlast [0] <= rx_axis_tlast;

        tdata [1] <= tdata [0];
        tkeep [1] <= tkeep [0];
        tvalid[1] <= tvalid[0];
        tlast [1] <= tlast [0];
    end
end

always @(posedge aclk) begin
    if (areset) begin
        state <= IDLE;
        optype <= 0;
        start_rx <= 0;
    end
    else begin
        case (state) 
            IDLE : begin
                if (rx_axis_tvalid & rx_axis_tkeep != 0) begin
                    state <= OP;
                end  
            end
            OP : begin
                if (rx_axis_tvalid & rx_axis_tkeep != 0) begin
                    optype <= rx_axis_tdata[47:32];
                    start_rx <= 1;
                    state <= DATA;
                end 
            end
            DATA : begin
                if (rx_axis_tvalid & rx_axis_tlast) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

always @(posedge aclk) begin
    if (start_rx & tvalid [1] & tkeep[1] != 0) begin
        if (optype == 16'h0608) begin
            arp_rx_axis_tdata <= tdata [1];
            arp_rx_axis_tkeep <= tkeep [1];
            arp_rx_axis_tlast <= tlast [1];
            arp_rx_axis_tvalid<= tvalid[1];
        end
    end
end

endmodule
