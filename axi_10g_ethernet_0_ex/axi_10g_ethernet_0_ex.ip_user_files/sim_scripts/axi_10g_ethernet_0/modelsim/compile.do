vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/ten_gig_eth_mac_v15_1_7
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/ten_gig_eth_pcs_pma_v6_0_16
vlib modelsim_lib/msim/xlconstant_v1_1_6

vmap xpm modelsim_lib/msim/xpm
vmap ten_gig_eth_mac_v15_1_7 modelsim_lib/msim/ten_gig_eth_mac_v15_1_7
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap ten_gig_eth_pcs_pma_v6_0_16 modelsim_lib/msim/ten_gig_eth_pcs_pma_v6_0_16
vmap xlconstant_v1_1_6 modelsim_lib/msim/xlconstant_v1_1_6

vlog -work xpm -64 -incr -sv \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work ten_gig_eth_mac_v15_1_7 -64 -incr \
"../../../ipstatic/hdl/ten_gig_eth_mac_v15_1_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/ten_gig_eth_mac_v15_1_1/hdl/bd_efdb_xmac_0_core.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_sync_resetn.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_block.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0.v" \

vlog -work ten_gig_eth_pcs_pma_v6_0_16 -64 -incr \
"../../../ipstatic/hdl/ten_gig_eth_pcs_pma_v6_0_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
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

vlog -work xlconstant_v1_1_6 -64 -incr \
"../../../ipstatic/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_2/sim/bd_efdb_prtad_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_3/sim/bd_efdb_dcm_locked_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_4/sim/bd_efdb_pma_pmd_type_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/sim/bd_efdb.v" \
"../../../ip/axi_10g_ethernet_0/sim/axi_10g_ethernet_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

