-makelib xcelium_lib/xpm -sv \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../../../STAR/STAR.srcs/sources_1/ip/ila_GTX_Encode/sim/ila_GTX_Encode.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

