vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/ten_gig_eth_mac_v15_1_7
vlib activehdl/xil_defaultlib
vlib activehdl/ten_gig_eth_pcs_pma_v6_0_16
vlib activehdl/xlconstant_v1_1_6

vmap xpm activehdl/xpm
vmap ten_gig_eth_mac_v15_1_7 activehdl/ten_gig_eth_mac_v15_1_7
vmap xil_defaultlib activehdl/xil_defaultlib
vmap ten_gig_eth_pcs_pma_v6_0_16 activehdl/ten_gig_eth_pcs_pma_v6_0_16
vmap xlconstant_v1_1_6 activehdl/xlconstant_v1_1_6

vlog -work xpm  -sv2k12 \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/App/Xilinx2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work ten_gig_eth_mac_v15_1_7  -v2k5 \
"../../../ipstatic/hdl/ten_gig_eth_mac_v15_1_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/ten_gig_eth_mac_v15_1_1/hdl/bd_efdb_xmac_0_core.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_sync_resetn.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_block.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0.v" \

vlog -work ten_gig_eth_pcs_pma_v6_0_16  -v2k5 \
"../../../ipstatic/hdl/ten_gig_eth_pcs_pma_v6_0_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
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

vlog -work xlconstant_v1_1_6  -v2k5 \
"../../../ipstatic/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_2/sim/bd_efdb_prtad_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_3/sim/bd_efdb_dcm_locked_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_4/sim/bd_efdb_pma_pmd_type_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/sim/bd_efdb.v" \
"../../../ip/axi_10g_ethernet_0/sim/axi_10g_ethernet_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

