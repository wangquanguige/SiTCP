//-----------------------------------------------------------------------------
// File       : bd_efdb_xmac_0.v
// Author     : Xilinx Inc.
// Description: This is the wrapper file for the Ten Gigabit Ethernet MAC.
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

// ------------------------------------------------------------------------------
// (c) Copyright 2001-2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 
// ------------------------------------------------------------------------------

(* CORE_GENERATION_INFO = "bd_efdb_xmac_0,ten_gig_eth_mac_v15_1_7,{x_ipProduct=Vivado 2019.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ten_gig_eth_mac,x_ipVersion=15.1,x_ipCoreRevision=7,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,c_family=kintex7,c_component_name=bd_efdb_xmac_0,c_has_stats=false,c_has_xgmii=false,c_has_management=true,c_has_wan_support=false,c_1588=0,c_pfc=false,c_tx_tuser_width=1,c_tx_stats_width=25,c_rx_stats_width=29,c_rx_vec_width=79,c_tx_vec_width=79,c_xgmii_data_width=63,c_xgmii_cntl_width=7,c_32bit=false,c_user_data_width=63,c_user_cntl_width=7,c_core_speed=10,c_axilite_freq=200,x_ipLicense=ten_gig_eth_mac@2016.04(bought)}" *)
(* X_CORE_INFO = "ten_gig_eth_mac_v15_1_7,Vivado 2019.2" *)
module bd_efdb_xmac_0
  (
   // Port declarations
   input                               tx_clk0,
   input                               reset,
   input  wire                         tx_axis_aresetn,
   input  wire [63 : 0]                tx_axis_tdata,
   input  wire [7:0]                   tx_axis_tkeep,
   input  wire                         tx_axis_tvalid,
   input  wire                         tx_axis_tlast,
   input  wire                         tx_axis_tuser,
   input  wire [7:0]                   tx_ifg_delay,
   output wire                         tx_axis_tready,
   output wire [25 : 0]                tx_statistics_vector,
   output wire                         tx_statistics_valid,
   input       [15 : 0]                pause_val,
   input                               pause_req,
   
   input wire                          rx_axis_aresetn,
   output wire [63 : 0]                rx_axis_tdata,
   output wire [7 : 0]                 rx_axis_tkeep,
   output wire                         rx_axis_tvalid,
   output wire                         rx_axis_tuser,
   output wire                         rx_axis_tlast,
   output wire [29 : 0]                rx_statistics_vector,
   output wire                         rx_statistics_valid,
   input                               s_axi_aclk,
   input                               s_axi_aresetn,
   
   input       [10:0]                  s_axi_awaddr,
   input                               s_axi_awvalid,
   output                              s_axi_awready,
   
   input       [31:0]                  s_axi_wdata,
   input                               s_axi_wvalid,
   output                              s_axi_wready,
   
   output      [1:0]                   s_axi_bresp,
   output                              s_axi_bvalid,
   input                               s_axi_bready,
   
   input       [10:0]                  s_axi_araddr,
   input                               s_axi_arvalid,
   output                              s_axi_arready,
   
   output      [31:0]                  s_axi_rdata,
   output      [1:0]                   s_axi_rresp,
   output                              s_axi_rvalid,
   input                               s_axi_rready,
   output wire                         xgmacint,
   output                              mdc,
   input                               mdio_in,
   output                              mdio_out,
   output                              mdio_tri,
   input                               tx_dcm_locked,
   output [63 : 0]                     xgmii_txd,
   output [7 : 0]                      xgmii_txc,
   input                               rx_clk0,
   input                               rx_dcm_locked,
   input [63 : 0]                      xgmii_rxd,
   input [7 : 0]                       xgmii_rxc);


bd_efdb_xmac_0_block inst (
   .tx_clk0                            (tx_clk0),
   .reset                              (reset),
   .tx_axis_aresetn                    (tx_axis_aresetn),
   .tx_axis_tdata                      (tx_axis_tdata),
   .tx_axis_tvalid                     (tx_axis_tvalid),
   .tx_axis_tlast                      (tx_axis_tlast),
   .tx_axis_tuser                      (tx_axis_tuser),
   .tx_ifg_delay                       (tx_ifg_delay),
   .tx_axis_tkeep                      (tx_axis_tkeep),
   .tx_axis_tready                     (tx_axis_tready),
   .tx_statistics_vector               (tx_statistics_vector),
   .tx_statistics_valid                (tx_statistics_valid),
   .pause_val                          (pause_val),
   .pause_req                          (pause_req),
   .rx_axis_aresetn                    (rx_axis_aresetn),
   .rx_axis_tdata                      (rx_axis_tdata),
   .rx_axis_tkeep                      (rx_axis_tkeep),
   .rx_axis_tvalid                     (rx_axis_tvalid),
   .rx_axis_tuser                      (rx_axis_tuser),
   .rx_axis_tlast                      (rx_axis_tlast),
   .rx_statistics_vector               (rx_statistics_vector),
   .rx_statistics_valid                (rx_statistics_valid),
   .s_axi_aclk                         (s_axi_aclk),
   .s_axi_aresetn                      (s_axi_aresetn),
   
   .s_axi_awaddr                       (s_axi_awaddr),
   .s_axi_awvalid                      (s_axi_awvalid),
   .s_axi_awready                      (s_axi_awready),
   
   .s_axi_wdata                        (s_axi_wdata),
   .s_axi_wvalid                       (s_axi_wvalid),
   .s_axi_wready                       (s_axi_wready),
   
   .s_axi_bresp                        (s_axi_bresp),
   .s_axi_bvalid                       (s_axi_bvalid),
   .s_axi_bready                       (s_axi_bready),
   
   .s_axi_araddr                       (s_axi_araddr),
   .s_axi_arvalid                      (s_axi_arvalid),
   .s_axi_arready                      (s_axi_arready),
   
   .s_axi_rdata                        (s_axi_rdata),
   .s_axi_rresp                        (s_axi_rresp),
   .s_axi_rvalid                       (s_axi_rvalid),
   .s_axi_rready                       (s_axi_rready),
   .xgmacint                           (xgmacint),
   .mdc                                (mdc),
   .mdio_in                            (mdio_in),
   .mdio_out                           (mdio_out),
   .mdio_tri                           (mdio_tri),
   .tx_dcm_locked                      (tx_dcm_locked),
   .xgmii_txd                          (xgmii_txd),
   .xgmii_txc                          (xgmii_txc),
   .rx_clk0                            (rx_clk0),
   .rx_dcm_locked                      (rx_dcm_locked),
   .xgmii_rxd                          (xgmii_rxd),
   .xgmii_rxc                          (xgmii_rxc));



endmodule
