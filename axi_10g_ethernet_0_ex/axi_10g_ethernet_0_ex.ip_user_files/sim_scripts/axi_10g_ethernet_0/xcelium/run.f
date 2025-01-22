-makelib xcelium_lib/xpm -sv \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/ten_gig_eth_mac_v15_1_7 \
  "../../../ipstatic/hdl/ten_gig_eth_mac_v15_1_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/ten_gig_eth_mac_v15_1_1/hdl/bd_efdb_xmac_0_core.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_sync_resetn.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_block.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0.v" \
-endlib
-makelib xcelium_lib/ten_gig_eth_pcs_pma_v6_0_16 \
  "../../../ipstatic/hdl/ten_gig_eth_pcs_pma_v6_0_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_gtwizard_10gbaser_gt.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_gtwizard_10gbaser_multi_gt.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_ff_synchronizer_rst.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_ff_synchronizer.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_local_clock_and_reset.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_sim_speedup_controller.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_cable_pull_logic.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_block.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_support.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_shared_clock_and_reset.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_gt_common.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_ff_synchronizer_rst2.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0.v" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_6 \
  "../../../ipstatic/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_2/sim/bd_efdb_prtad_driver_0.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_3/sim/bd_efdb_dcm_locked_driver_0.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_4/sim/bd_efdb_pma_pmd_type_driver_0.v" \
  "../../../ip/axi_10g_ethernet_0/bd_0/sim/bd_efdb.v" \
  "../../../ip/axi_10g_ethernet_0/sim/axi_10g_ethernet_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

