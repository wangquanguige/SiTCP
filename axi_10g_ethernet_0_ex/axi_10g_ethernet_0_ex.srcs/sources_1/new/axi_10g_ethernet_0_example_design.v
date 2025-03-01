`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/22 11:19:10
// Design Name: 
// Module Name: axi_10g_ethernet_0_example_design
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


// ----------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
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
// ----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Title      : Example Design top level
// Project    : 10G Gigabit Ethernet
//-----------------------------------------------------------------------------
// File       : Ethernet_10G_example_design.v
// Author     : Xilinx Inc.
//-----------------------------------------------------------------------------
// Description: This is the example design top level code for the 10G
//              Gigabit Ethernet IP.  It contains the FIFO block of the example
//              design along with a frame pattern generator and checker.
//-----------------------------------------------------------------------------


(* DowngradeIPIdentifiedWarnings = "yes" *)
module axi_10g_ethernet_0_example_design
  (
   // Clock inputs
   input            s_axi_aclk,       // axi clock source
   input            refclk_p,         // Transceiver reference clock source
   input            refclk_n,
   
   // User interface
   output           userclk_out,
   
   output           tx_axis_tready,
   input    [63:0]  tx_axis_tdata,
   input    [7:0]   tx_axis_tkeep,
   input            tx_axis_tlast,
   input            tx_axis_tvalid,
   
   output   [63:0]  rx_axis_tdata,
   output   [7:0]   rx_axis_tkeep,
   output           rx_axis_tvalid,
   output           rx_axis_tlast,
   input            rx_axis_tready,
   
   // Control inputs
   input             reset,

   // status outputs
   output            core_ready,

   // Serial I/O from/to transceiver
   output            txp,
   output            txn,
   input             rxp,
   input             rxn
   );
/*-------------------------------------------------------------------------*/

   // Set FIFO memory size
   localparam        FIFO_SIZE  = 1024;

   // Signal declarations
   wire              coreclk;
   wire              block_lock;
   wire              rxrecclk;
   wire             qplllock_out;

   wire              tx_s_axis_aresetn;
   wire              tx_s_axis_areset;

   wire     [10:0]   s_axi_awaddr;
   wire              s_axi_awvalid;

   wire              s_axi_awready;
   wire     [31:0]   s_axi_wdata;
   wire              s_axi_wvalid;
   wire              s_axi_wready;

   wire     [1:0]    s_axi_bresp;
   wire              s_axi_bvalid;
   wire              s_axi_bready;
   wire     [10:0]   s_axi_araddr;
   wire              s_axi_arvalid;
   wire              s_axi_arready;

   wire     [31:0]   s_axi_rdata;
   wire     [1:0]    s_axi_rresp;
   wire              s_axi_rvalid;
   wire              s_axi_rready;

   wire              tx_statistics_vector;
   wire              rx_statistics_vector;
   wire     [25:0]   tx_statistics_vector_int;
   wire              tx_statistics_valid_int;
   reg               tx_statistics_valid;
   reg      [27:0]   tx_statistics_shift = 0;
   wire     [29:0]   rx_statistics_vector_int;
   wire              rx_statistics_valid_int;
   reg               rx_statistics_valid;
   reg      [31:0]   rx_statistics_shift = 0;

//   wire     [63:0]   tx_axis_tdata;
//   wire     [7:0]    tx_axis_tkeep;
//   wire              tx_axis_tvalid;
//   wire              tx_axis_tlast;
//   wire              tx_axis_tready;
//   wire     [63:0]   rx_axis_tdata;
//   wire     [7:0]    rx_axis_tkeep;
//   wire              rx_axis_tvalid;
//   wire              rx_axis_tlast;
//   wire              rx_axis_tready;
   wire              tx_reset;
   wire              rx_reset;

   wire              tx_axis_aresetn;
   wire              rx_axis_aresetn;

   wire              resetdone_out;
   wire      [7:0]   pcspma_status;

   assign   userclk_out = coreclk;
   assign   core_ready  = block_lock;

   // Combine reset sources
   assign  tx_axis_aresetn    = ~reset;     //mdz
   assign  rx_axis_aresetn    = ~reset;     //mdz
   assign  tx_s_axis_aresetn  = ~reset;     //mdz

   // The serialized statistics vector output is intended to only prevent logic stripping
   assign serialized_stats = tx_statistics_vector || rx_statistics_vector;

   assign tx_reset  = reset;
   assign rx_reset  = reset;

    //--------------------------------------------------------------------------
    // Instantiate a module containing the Ethernet core and an example FIFO
    //--------------------------------------------------------------------------
    axi_10g_ethernet_0_fifo_block #(
      .FIFO_SIZE                       (FIFO_SIZE)
    ) fifo_block_i (
      .refclk_p                        (refclk_p),
      .refclk_n                        (refclk_n),
      .coreclk_out                     (coreclk),
      .rxrecclk_out                    (rxrecclk),
      .dclk                            (s_axi_aclk),

      .reset                           (reset),

      .tx_ifg_delay                    (8'd0),

      .tx_statistics_vector            (tx_statistics_vector_int),
      .tx_statistics_valid             (tx_statistics_valid_int),
      .rx_statistics_vector            (rx_statistics_vector_int),
      .rx_statistics_valid             (rx_statistics_valid_int),

      .pause_val                       (16'b0),
      .pause_req                       (1'b0),

      .rx_axis_fifo_aresetn            (rx_axis_aresetn),
      .rx_axis_mac_aresetn             (rx_axis_aresetn),
      .rx_axis_fifo_tdata              (rx_axis_tdata),
      .rx_axis_fifo_tkeep              (rx_axis_tkeep),
      .rx_axis_fifo_tvalid             (rx_axis_tvalid),
      .rx_axis_fifo_tlast              (rx_axis_tlast),
      .rx_axis_fifo_tready             (rx_axis_tready),
      .tx_axis_mac_aresetn             (tx_axis_aresetn),
      .tx_axis_fifo_aresetn            (tx_axis_aresetn),
      .tx_axis_fifo_tdata              (tx_axis_tdata),
      .tx_axis_fifo_tkeep              (tx_axis_tkeep),
      .tx_axis_fifo_tvalid             (tx_axis_tvalid),
      .tx_axis_fifo_tlast              (tx_axis_tlast),
      .tx_axis_fifo_tready             (tx_axis_tready),

      .s_axi_aclk                      (s_axi_aclk),
      .s_axi_aresetn                   (tx_s_axis_aresetn),
      .s_axi_awaddr                    (s_axi_awaddr),
      .s_axi_awvalid                   (s_axi_awvalid),
      .s_axi_awready                   (s_axi_awready),
      .s_axi_wdata                     (s_axi_wdata),
      .s_axi_wvalid                    (s_axi_wvalid),
      .s_axi_wready                    (s_axi_wready),
      .s_axi_bresp                     (s_axi_bresp),
      .s_axi_bvalid                    (s_axi_bvalid),
      .s_axi_bready                    (s_axi_bready),
      .s_axi_araddr                    (s_axi_araddr),
      .s_axi_arvalid                   (s_axi_arvalid),
      .s_axi_arready                   (s_axi_arready),
      .s_axi_rdata                     (s_axi_rdata),
      .s_axi_rresp                     (s_axi_rresp),
      .s_axi_rvalid                    (s_axi_rvalid),
      .s_axi_rready                    (s_axi_rready),

      .xgmacint                        (),

      .txp                             (txp),
      .txn                             (txn),
      .rxp                             (rxp),
      .rxn                             (rxn),

      .signal_detect                   (1'b1),
      .tx_fault                        (1'b0),
      .sim_speedup_control             (~reset),            //mdz
      .pcspma_status                   (pcspma_status),
      .resetdone_out                   (resetdone_out),
      .qplllock_out                    (qplllock_out)
      );

    //--------------------------------------------------------------------------
    // Instantiate the AXI-LITE Controller
    //--------------------------------------------------------------------------

    axi_10g_ethernet_0_axi_lite_sm axi_lite_controller (
      .s_axi_aclk                      (s_axi_aclk),
      .s_axi_reset                     (tx_s_axis_areset),

      .pcs_loopback                    (1'b0),          //mdz    
      .enable_vlan                     (1'b0),          //mdz    
      .enable_custom_preamble          (1'b0),          //mdz    

      .block_lock                      (block_lock),
      .enable_gen                      (),              //mdz    

      .s_axi_awaddr                    (s_axi_awaddr),
      .s_axi_awvalid                   (s_axi_awvalid),
      .s_axi_awready                   (s_axi_awready),

      .s_axi_wdata                     (s_axi_wdata),
      .s_axi_wvalid                    (s_axi_wvalid),
      .s_axi_wready                    (s_axi_wready),

      .s_axi_bresp                     (s_axi_bresp),
      .s_axi_bvalid                    (s_axi_bvalid),
      .s_axi_bready                    (s_axi_bready),

      .s_axi_araddr                    (s_axi_araddr),
      .s_axi_arvalid                   (s_axi_arvalid),
      .s_axi_arready                   (s_axi_arready),

      .s_axi_rdata                     (s_axi_rdata),
      .s_axi_rresp                     (s_axi_rresp),
      .s_axi_rvalid                    (s_axi_rvalid),
      .s_axi_rready                    (s_axi_rready)
   );

    (* mark_debug = "TRUE" *)reg tcp_en = 0;

   initial begin
      @(posedge coreclk) begin
        #65000000
         tcp_en <= 1;

         @(posedge coreclk) begin
            tcp_en <= 0;
         end
      end
   end

   axi_10g_ethernet_0_arp_block #(
      .show_output_block               (1)                     ,
      .show_message_type               (1)
   )
   arp_block (
      .aclk                            (coreclk)               ,
      .areset                          (areset)                ,

      .tx_axis_tdata                   (tx_axis_tdata)         ,
      .tx_axis_tkeep                   (tx_axis_tkeep)         ,
      .tx_axis_tvalid                  (tx_axis_tvalid)        ,
      .tx_axis_tlast                   (tx_axis_tlast)         ,
      .tx_axis_tready                  (tx_axis_tready)        ,

      .rx_axis_tdata                   (rx_axis_tdata)         ,
      .rx_axis_tkeep                   (rx_axis_tkeep)         ,
      .rx_axis_tvalid                  (rx_axis_tvalid)        ,
      .rx_axis_tlast                   (rx_axis_tlast)         ,
      .rx_axis_tready                  (rx_axis_tready)        ,

      .arp_request_ip                  (32'h12_12_12_12)       ,
      .tx_tcp_en                       (tcp_en)                
   );


/*ila_1 ila_test (
	.clk(coreclk), // input wire clk


	//.probe0(rx_axis_tdata), // input wire [63:0]  probe0  
	.probe1(tcp_en) // input wire [0:0]  probe1
);*/

    //--------------------------------------------------------------------------
    // Add reset synchronizers to the asynchronous reset inputs
    //--------------------------------------------------------------------------
    axi_10g_ethernet_0_sync_reset tx_s_axis_reset_gen (
      .clk                             (s_axi_aclk),
      .reset_in                        (~tx_s_axis_aresetn),
      .reset_out                       (tx_s_axis_areset)
      );

    //--------------------------------------------------------------------------
    // Instantiate the pattern generator / pattern checker and loopback module
    //--------------------------------------------------------------------------
     

   //--------------------------------------------------------------------------
   // serialise the stats vector output to ensure logic isn't stripped during
   // synthesis and to reduce the IO required by the example design
   //--------------------------------------------------------------------------
   always @(posedge coreclk)
   begin
     tx_statistics_valid               <= tx_statistics_valid_int;
     if (tx_statistics_valid_int & !tx_statistics_valid) begin
        tx_statistics_shift            <= {2'b01,tx_statistics_vector_int};
     end
     else begin
        tx_statistics_shift            <= {tx_statistics_shift[26:0], 1'b0};
     end
   end

   assign tx_statistics_vector         = tx_statistics_shift[27];

   always @(posedge coreclk)
   begin
     rx_statistics_valid               <= rx_statistics_valid_int;
     if (rx_statistics_valid_int & !rx_statistics_valid) begin
        rx_statistics_shift            <= {2'b01, rx_statistics_vector_int};
     end
     else begin
        rx_statistics_shift            <= {rx_statistics_shift[30:0], 1'b0};
     end
   end

   assign rx_statistics_vector         = rx_statistics_shift[31];
    

endmodule

