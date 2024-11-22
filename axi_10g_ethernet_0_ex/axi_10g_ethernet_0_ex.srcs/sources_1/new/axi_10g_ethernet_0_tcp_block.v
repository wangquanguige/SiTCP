`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 17:05:05
// Design Name: 
// Module Name: axi_10g_ethernet_0_tcp_block
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


module axi_10g_ethernet_0_tcp_block (
   input wire  [47:0]                  dest_addr,
   input wire  [47:0]                  src_addr,
   input wire  [14:0]                  max_size,
   input wire  [14:0]                  min_size,
   input wire                          enable_vlan,
   input wire  [11:0]                  vlan_id,
   input wire  [2:0]                   vlan_priority,
   input wire  [55:0]                  preamble_data,
   input wire                          enable_custom_preamble,

   input wire                          aclk,
   input wire                          aresetn,
   input wire                          reset_error,
   input wire                          insert_error,
   input wire                          enable_pat_gen,
   input wire                          enable_pat_check,
   input wire                          enable_loopback,

   // data from the RX data path
   input       [63:0]                  rx_axis_tdata,
   input       [7:0]                   rx_axis_tkeep,
   input                               rx_axis_tvalid,
   input                               rx_axis_tlast,
   output                              rx_axis_tready,

   // data to the TX data path
   output      [63:0]                  tcp_tx_axis_tdata,
   output      [7:0]                   tcp_tx_axis_tkeep,
   output                              tcp_tx_axis_tvalid,
   output                              tcp_tx_axis_tlast,
   output                              tcp_tx_axis_en,
   input                               tcp_tx_axis_tready,

   // ARP ADDR MAP
   output      [47:0]                  rx_arp_mac,
   output      [31:0]                  rx_arp_ip,
   output                              rx_arp_en,

   // signal to send ARP request
   input                               tx_arp,
   input       [31:0]                  tx_arp_ip,

   output wire                         gen_active_flash,
   output wire                         check_active_flash,
   output wire                         frame_error
);

   wire                                areset;
   wire        [63:0]                  rx_axis_tdata_int;
   wire        [7:0]                   rx_axis_tkeep_int;
   wire                                rx_axis_tvalid_int;
   wire                                rx_axis_tlast_int;
   wire                                rx_axis_tready_int;

   wire        [63:0]                  pat_gen_tdata;
   wire        [7:0]                   pat_gen_tkeep;
   wire                                pat_gen_tvalid;
   wire                                pat_gen_tlast;
   wire                                pat_gen_tready;

   wire        [63:0]                  mux_tdata;
   wire        [7:0]                   mux_tkeep;
   wire                                mux_tvalid;
   wire                                mux_tlast;
   wire                                mux_tready;

   wire        [63:0]                  tx_axis_as_tdata;
   wire        [7:0]                   tx_axis_as_tkeep;
   wire                                tx_axis_as_tvalid;
   wire                                tx_axis_as_tlast;
   wire                                tx_axis_as_tready;

   wire                                enable_pat_gen_sync;
   wire                                enable_pat_check_sync;
   wire                                enable_loopback_sync;


   assign tcp_tx_axis_tdata                = tx_axis_as_tdata;
   assign tcp_tx_axis_tkeep                = tx_axis_as_tkeep;
   assign tcp_tx_axis_tvalid               = tx_axis_as_tvalid;
   assign tcp_tx_axis_tlast                = tx_axis_as_tlast;
   assign tcp_tx_axis_en                   = tx_axis_as_tlast;
   assign tx_axis_as_tready            = tcp_tx_axis_tready;
   assign rx_axis_tready               = tx_axis_as_tready;

   axi_10g_ethernet_0_sync_reset areset_gen (
      .clk                             (aclk),
      .reset_in                        (~aresetn),
      .reset_out                       (areset)
      );

   axi_10g_ethernet_0_sync_block sync_pat_gen (
      .data_in                         (enable_pat_gen),
      .clk                             (aclk),
      .data_out                        (enable_pat_gen_sync)
   );

   axi_10g_ethernet_0_sync_block sync_pat_chk (
      .data_in                         (enable_pat_check),
      .clk                             (aclk),
      .data_out                        (enable_pat_check_sync)
   );

   axi_10g_ethernet_0_sync_block sync_loopback_enable (
      .clk                             (aclk),
      .data_in                         (enable_loopback),
      .data_out                        (enable_loopback_sync)
   );

    axi_10g_ethernet_0_tcp_rx_block tcp_rx (
      .aclk                            (aclk),
      .areset                          (areset),

      .rx_tdata                        (rx_axis_tdata),
      .rx_tkeep                        (rx_axis_tkeep),
      .rx_tvalid                       (rx_axis_tvalid),
      .rx_tlast                        (rx_axis_tlast),

      .inter_tdata                     (inter_tdata),
      .inter_tkeep                     (inter_tkeep),
      .inter_tvalid                    (inter_tvalid),
      .inter_tlast                     (inter_tlast)
    );

    axi_10g_ethernet_0_tcp_tx_block tcp_tx (
      .aclk                            (aclk),
      .areset                          (areset),

      .tx_tdata                        (inter_tdata),
      .tx_tkeep                        (inter_tkeep),
      .tx_tvalid                       (inter_tvalid),
      .tx_tlast                        (inter_tlast),

      .inter_tdata                     (tcp_tx_axis_tdata),
      .inter_tkeep                     (tcp_tx_axis_tkeep),
      .inter_tvalid                    (tcp_tx_axis_tvalid),
      .inter_tlast                     (tcp_tx_axis_tlast)
    );

endmodule

