-makelib ies_lib/xpm -sv \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../ip/ila_1/sim/ila_1.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

