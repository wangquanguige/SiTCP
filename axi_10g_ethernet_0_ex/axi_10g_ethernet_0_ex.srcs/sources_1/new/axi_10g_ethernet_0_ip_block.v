`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 17:25:41
// Design Name: 
// Module Name: axi_10g_ethernet_0_ip_block
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


module axi_10g_ethernet_0_ip_block (
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
   output      [63:0]                  tx_axis_tdata,
   output      [7:0]                   tx_axis_tkeep,
   output                              tx_axis_tvalid,
   output                              tx_axis_tlast,
   input                               tx_axis_tready,

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

   wire          [15:0]      optype;
   wire          [63:0]      arp_head;
   wire          [47:0]      arp_src_mac;
   wire          [31:0]      arp_src_ip;
   wire                      arp_rx_done;
   wire                      icmp_rx_done;
   wire          [63:0]      icmp_data_0;
   wire          [63:0]      icmp_data_1;
   wire          [63:0]      icmp_data_2;
   wire          [63:0]      icmp_data_3;  
   wire          [15:0]      icmp_identification;
   wire          [15:0]      icmp_sequence_number;

   assign tx_axis_tdata                = tx_axis_as_tdata;
   assign tx_axis_tkeep                = tx_axis_as_tkeep;
   assign tx_axis_tvalid               = tx_axis_as_tvalid;
   assign tx_axis_tlast                = tx_axis_as_tlast;
   assign tx_axis_as_tready            = tx_axis_tready;
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

   axi_10g_ethernet_0_axi_pat_gen generator (
      .dest_addr                       (dest_addr),
      .src_addr                        (src_addr),
      .max_size                        (max_size),
      .min_size                        (min_size),
      .enable_vlan                     (enable_vlan),
      .vlan_id                         (vlan_id),
      .vlan_priority                   (vlan_priority),
      .preamble_data                   (preamble_data),
      .enable_custom_preamble          (enable_custom_preamble),

      .aclk                            (aclk),
      .areset                          (areset),
      .insert_error                    (insert_error),
      .enable_pat_gen                  (enable_pat_gen_sync),

      .tdata                           (pat_gen_tdata),
      .tkeep                           (pat_gen_tkeep),
      .tvalid                          (pat_gen_tvalid),
      .tlast                           (pat_gen_tlast),
      .tready                          (pat_gen_tready),
      .gen_active_flash                (gen_active_flash)
   );

   // simple mux between the rx_fifo AXI interface and the pat gen output
   /*axi_10g_ethernet_0_axi_mux axi_mux_inst (
      .mux_select                      (enable_loopback_sync),

      .tdata0                          (pat_gen_tdata),
      .tkeep0                          (pat_gen_tkeep),
      .tvalid0                         (pat_gen_tvalid),
      .tlast0                          (pat_gen_tlast),
      .tready0                         (pat_gen_tready),

      .tdata1                          (rx_axis_tdata),
      .tkeep1                          (rx_axis_tkeep),
      .tvalid1                         (rx_axis_tvalid),
      .tlast1                          (rx_axis_tlast),
      .tready1                         (rx_axis_tready_int),

      .tdata                           (mux_tdata),
      .tkeep                           (mux_tkeep),
      .tvalid                          (mux_tvalid),
      .tlast                           (mux_tlast),
      .tready                          (mux_tready)
   );*/

   axi_10g_ethernet_0_ip_parser ip_parser (
      .aclk                            (aclk),
      .areset                          (areset),

      .mux_select                      (enable_loopback_sync),

      .tdata0                          (pat_gen_tdata),
      .tkeep0                          (pat_gen_tkeep),
      .tvalid0                         (pat_gen_tvalid),
      .tlast0                          (pat_gen_tlast),
      .tready0                         (pat_gen_tready),

      .tdata1                          (rx_axis_tdata),
      .tkeep1                          (rx_axis_tkeep),
      .tvalid1                         (rx_axis_tvalid),
      .tlast1                          (rx_axis_tlast),
      .tready1                         (rx_axis_tready_int),

      .tdata                           (mux_tdata),
      .tkeep                           (mux_tkeep),
      .tvalid                          (mux_tvalid),
      .tlast                           (mux_tlast),
      .tready                          (mux_tready),

      .optype                           (optype),
      .arp_head                         (arp_head),
      .arp_src_mac                      (arp_src_mac),
      .arp_src_ip                       (arp_src_ip),

      .icmp_data_0                      (icmp_data_0),
      .icmp_data_1                      (icmp_data_1),
      .icmp_data_2                      (icmp_data_2),
      .icmp_data_3                      (icmp_data_3),
      .icmp_identification              (icmp_identification),
      .icmp_sequence_number             (icmp_sequence_number),
      .arp_rx_done                      (arp_rx_done),
      .icmp_rx_done                     (icmp_rx_done)
   );


   // address swap module: based around a Dual port distributed ram
   // data is written in and the read only starts once the da/sa have been
   // stored.
/*
   axi_10g_ethernet_0_address_swap address_swap (
      .aclk                            (aclk),
      .areset                          (areset),
      .enable_custom_preamble          (enable_custom_preamble),
      .address_swap_enable             (enable_loopback_sync),  // do the address swap when in loopback

      .rx_axis_tdata                   (mux_tdata),
      .rx_axis_tkeep                   (mux_tkeep),
      .rx_axis_tvalid                  (mux_tvalid),
      .rx_axis_tlast                   (mux_tlast),
      .rx_axis_tready                  (mux_tready),
      .tx_axis_tdata                   (tx_axis_as_tdata),
      .tx_axis_tkeep                   (tx_axis_as_tkeep),
      .tx_axis_tvalid                  (tx_axis_as_tvalid),
      .tx_axis_tlast                   (tx_axis_as_tlast),
      .tx_axis_tready                  (tx_axis_as_tready)
   );
*/
    axi_10g_ethernet_0_ip_generator ip_generator (
      .aclk                            (aclk),
      .areset                          (areset),

      .optype                           (optype),
      .arp_head                         (arp_head),
      .arp_dec_mac                      (arp_src_mac),
      .arp_dec_ip                       (arp_src_ip),
      .arp_rx_done                      (arp_rx_done),

      .icmp_data_0                      (icmp_data_0),
      .icmp_data_1                      (icmp_data_1),
      .icmp_data_2                      (icmp_data_2),
      .icmp_data_3                      (icmp_data_3),
      .icmp_identification              (icmp_identification),
      .icmp_sequence_number             (icmp_sequence_number),
      .icmp_rx_done                     (icmp_rx_done),

      .tx_axis_tdata                   (tx_axis_as_tdata),
      .tx_axis_tkeep                   (tx_axis_as_tkeep),
      .tx_axis_tvalid                  (tx_axis_as_tvalid),
      .tx_axis_tlast                   (tx_axis_as_tlast)
    );


   axi_10g_ethernet_0_axi_pat_check checker(
      .dest_addr                       (dest_addr),
      .src_addr                        (src_addr),
      .max_size                        (max_size),
      .min_size                        (min_size),
      .enable_vlan                     (enable_vlan),
      .vlan_id                         (vlan_id),
      .vlan_priority                   (vlan_priority),
      .preamble_data                   (preamble_data),
      .enable_custom_preamble          (enable_custom_preamble),

      .aclk                            (aclk),
      .areset                          (areset),
      .reset_error                     (reset_error),
      .enable_pat_check                (enable_pat_check_sync),

      .tdata                           (rx_axis_tdata),
      .tkeep                           (rx_axis_tkeep),
      .tvalid                          (rx_axis_tvalid),
      .tlast                           (rx_axis_tlast),
      .tready                          (rx_axis_tready_int),
      .tuser                           (1'b1),
      .frame_error                     (frame_error),
      .check_active_flash              (check_active_flash)
   );

endmodule
