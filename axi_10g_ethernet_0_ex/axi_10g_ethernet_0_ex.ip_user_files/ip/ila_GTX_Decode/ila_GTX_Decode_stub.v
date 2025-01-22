// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Jan 22 11:04:01 2025
// Host        : DESKTOP-4V0BJ5M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/123/Documents/xilinx_project/STAR/STAR.srcs/sources_1/ip/ila_GTX_Decode/ila_GTX_Decode_stub.v
// Design      : ila_GTX_Decode
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2019.2" *)
module ila_GTX_Decode(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[149:0]" */;
  input clk;
  input [149:0]probe0;
endmodule
