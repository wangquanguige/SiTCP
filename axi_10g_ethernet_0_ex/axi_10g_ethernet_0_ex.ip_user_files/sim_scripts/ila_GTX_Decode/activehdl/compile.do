vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Decode/hdl/verilog" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Decode/hdl/verilog" \
"../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Decode/sim/ila_GTX_Decode.v" \

vlog -work xil_defaultlib \
"glbl.v"

