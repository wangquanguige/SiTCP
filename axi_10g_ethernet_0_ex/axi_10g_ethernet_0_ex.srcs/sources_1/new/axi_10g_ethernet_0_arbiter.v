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


module axi_10g_ethernet_0_arbiter(
   input                               aclk,
   input                               aresetn,

   input       [63:0]                  rx_axis_tdata,
   input       [7:0]                   rx_axis_tkeep,
   input                               rx_axis_tvalid,
   input                               rx_axis_tlast,

   output      [63:0]                  tx_axis_tdata,
   output      [7:0]                   tx_axis_tkeep,
   output                              tx_axis_tvalid,
   output                              tx_axis_tlast
);

localparam IDLE = 0,
           

assign tx_axis_tdata = rx_axis_tdata;
assign tx_axis_tkeep = rx_axis_tkeep;
assign tx_axis_tvalid = rx_axis_tvalid;
assign tx_axis_tlast = rx_axis_tlast;

reg [47:0] mac_list[9:0];
reg [31:0] ip_list[9:0];
reg [3:0] list_index = 4'b0;

reg [1:0] state;

always @(posedge aclk) begin
    if (!areset) begin
        state <= IDLE;
        list_index <= 0;
    end
end

always @(posedge aclk) begin
    case (state)
        IDLE : begin
            
        end
    endcase
end

endmodule
