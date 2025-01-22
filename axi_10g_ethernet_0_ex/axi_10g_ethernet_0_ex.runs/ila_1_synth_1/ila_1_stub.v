// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Jan 22 14:50:51 2025
// Host        : DESKTOP-4V0BJ5M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.runs/ila_1_synth_1/ila_1_stub.v
// Design      : ila_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2019.2" *)
module ila_1(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[63:0],probe1[0:0]" */;
  input clk;
  input [63:0]probe0;
  input [0:0]probe1;
endmodule
