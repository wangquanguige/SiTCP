vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -sv "+incdir+../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Encode/hdl/verilog" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Encode/hdl/verilog" \
"../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Encode/sim/ila_GTX_Encode.v" \

vlog -work xil_defaultlib \
"glbl.v"

