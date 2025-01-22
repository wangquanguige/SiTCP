#set_false_path -to [get_pins [list GTX_ROD_Datalink_inst/gt0_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt0_txfsmresetdone_r_reg/CLR #          GTX_ROD_Datalink_inst/gt1_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt1_txfsmresetdone_r_reg/CLR #          GTX_ROD_Datalink_inst/gt2_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt2_txfsmresetdone_r_reg/CLR #          GTX_ROD_Datalink_inst/gt3_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt3_txfsmresetdone_r_reg/CLR #          GTX_ROD_Datalink_inst/gt4_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt4_txfsmresetdone_r_reg/CLR #          GTX_ROD_Datalink_inst/gt5_txfsmresetdone_r2_reg/CLR #          GTX_ROD_Datalink_inst/gt5_txfsmresetdone_r_reg/CLR]]
#set_false_path -to [get_pins [list GTX_ROD_Datalink_inst/gt0_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt0_txfsmresetdone_r_reg/D #          GTX_ROD_Datalink_inst/gt1_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt1_txfsmresetdone_r_reg/D #          GTX_ROD_Datalink_inst/gt2_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt2_txfsmresetdone_r_reg/D #          GTX_ROD_Datalink_inst/gt3_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt3_txfsmresetdone_r_reg/D #          GTX_ROD_Datalink_inst/gt4_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt4_txfsmresetdone_r_reg/D #          GTX_ROD_Datalink_inst/gt5_txfsmresetdone_r2_reg/D #          GTX_ROD_Datalink_inst/gt5_txfsmresetdone_r_reg/D]]

set_property IOSTANDARD LVDS_25 [get_ports CLK_OnBoard_p]
set_property PACKAGE_PIN T26 [get_ports CLK_OnBoard_p]
set_property PACKAGE_PIN T27 [get_ports CLK_OnBoard_n]
set_property IOSTANDARD LVDS_25 [get_ports CLK_OnBoard_n]

set_property PACKAGE_PIN L12 [get_ports ROD_TDO]
set_property IOSTANDARD LVCMOS18 [get_ports ROD_TDO]

set_property PACKAGE_PIN L13 [get_ports ROD_TDI]
set_property IOSTANDARD LVCMOS18 [get_ports ROD_TDI]

set_property PACKAGE_PIN K11 [get_ports ROD_TMS]
set_property IOSTANDARD LVCMOS18 [get_ports ROD_TMS]

set_property PACKAGE_PIN L11 [get_ports ROD_TCK]
set_property IOSTANDARD LVCMOS18 [get_ports ROD_TCK]

set_property PACKAGE_PIN J29 [get_ports FEB_TDO]
set_property IOSTANDARD LVCMOS18 [get_ports FEB_TDO]

set_property PACKAGE_PIN H29 [get_ports FEB_TDI]
set_property IOSTANDARD LVCMOS18 [get_ports FEB_TDI]

set_property PACKAGE_PIN J27 [get_ports FEB_TMS]
set_property IOSTANDARD LVCMOS18 [get_ports FEB_TMS]

set_property PACKAGE_PIN J28 [get_ports FEB_TCK]
set_property IOSTANDARD LVCMOS18 [get_ports FEB_TCK]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB1_clk_p]
set_property PACKAGE_PIN K28 [get_ports FEB1_clk_p]
set_property PACKAGE_PIN K29 [get_ports FEB1_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB1_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB1_p]
set_property PACKAGE_PIN L26 [get_ports ROD_CMD_FEB1_p]
set_property PACKAGE_PIN L27 [get_ports ROD_CMD_FEB1_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB1_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB1_Response_p]
set_property PACKAGE_PIN M24 [get_ports FEB1_Response_p]
set_property PACKAGE_PIN M25 [get_ports FEB1_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB1_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB1_p]
set_property PACKAGE_PIN M29 [get_ports Trigger_FEB1_p]
set_property PACKAGE_PIN M30 [get_ports Trigger_FEB1_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB1_n]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB2_clk_p]
set_property PACKAGE_PIN L25 [get_ports FEB2_clk_p]
set_property PACKAGE_PIN K25 [get_ports FEB2_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB2_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB2_p]
set_property PACKAGE_PIN N21 [get_ports ROD_CMD_FEB2_p]
set_property PACKAGE_PIN N22 [get_ports ROD_CMD_FEB2_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB2_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB2_Response_p]
set_property PACKAGE_PIN N19 [get_ports FEB2_Response_p]
set_property PACKAGE_PIN N20 [get_ports FEB2_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB2_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB2_p]
set_property PACKAGE_PIN M22 [get_ports Trigger_FEB2_p]
set_property PACKAGE_PIN M23 [get_ports Trigger_FEB2_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB2_n]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB3_clk_p]
set_property PACKAGE_PIN D17 [get_ports FEB3_clk_p]
set_property PACKAGE_PIN D18 [get_ports FEB3_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB3_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB3_p]
set_property PACKAGE_PIN H20 [get_ports ROD_CMD_FEB3_p]
set_property PACKAGE_PIN G20 [get_ports ROD_CMD_FEB3_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB3_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB3_Response_p]
set_property PACKAGE_PIN J19 [get_ports FEB3_Response_p]
set_property PACKAGE_PIN H19 [get_ports FEB3_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB3_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB3_p]
set_property PACKAGE_PIN D21 [get_ports Trigger_FEB3_p]
set_property PACKAGE_PIN C21 [get_ports Trigger_FEB3_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB3_n]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB4_clk_p]
set_property PACKAGE_PIN F20 [get_ports FEB4_clk_p]
set_property PACKAGE_PIN E20 [get_ports FEB4_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB4_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB4_p]
set_property PACKAGE_PIN G17 [get_ports ROD_CMD_FEB4_p]
set_property PACKAGE_PIN F17 [get_ports ROD_CMD_FEB4_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB4_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB4_Response_p]
set_property PACKAGE_PIN J17 [get_ports FEB4_Response_p]
set_property PACKAGE_PIN H17 [get_ports FEB4_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB4_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB4_p]
set_property PACKAGE_PIN G18 [get_ports Trigger_FEB4_p]
set_property PACKAGE_PIN F18 [get_ports Trigger_FEB4_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB4_n]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB5_clk_p]
set_property PACKAGE_PIN D12 [get_ports FEB5_clk_p]
set_property PACKAGE_PIN D13 [get_ports FEB5_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB5_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB5_p]
set_property PACKAGE_PIN J11 [get_ports ROD_CMD_FEB5_p]
set_property PACKAGE_PIN J12 [get_ports ROD_CMD_FEB5_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB5_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB5_Response_p]
set_property PACKAGE_PIN K13 [get_ports FEB5_Response_p]
set_property PACKAGE_PIN J13 [get_ports FEB5_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB5_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB5_p]
set_property PACKAGE_PIN H11 [get_ports Trigger_FEB5_p]
set_property PACKAGE_PIN H12 [get_ports Trigger_FEB5_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB5_n]


set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB6_clk_p]
set_property PACKAGE_PIN G13 [get_ports FEB6_clk_p]
set_property PACKAGE_PIN F13 [get_ports FEB6_clk_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB6_clk_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB6_p]
set_property PACKAGE_PIN L15 [get_ports ROD_CMD_FEB6_p]
set_property PACKAGE_PIN K15 [get_ports ROD_CMD_FEB6_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports ROD_CMD_FEB6_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB6_Response_p]
set_property PACKAGE_PIN L16 [get_ports FEB6_Response_p]
set_property PACKAGE_PIN K16 [get_ports FEB6_Response_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports FEB6_Response_n]

set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB6_p]
set_property PACKAGE_PIN K14 [get_ports Trigger_FEB6_p]
set_property PACKAGE_PIN J14 [get_ports Trigger_FEB6_n]
set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports Trigger_FEB6_n]


set_property PACKAGE_PIN AB27 [get_ports External_Trigger]
set_property IOSTANDARD LVCMOS33 [get_ports External_Trigger]

# GTX
create_clock -period 5.000 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]


set_property PACKAGE_PIN G8 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]
set_property PACKAGE_PIN G7 [get_ports Q2_CLK0_GTREFCLK_PAD_N_IN]

# debug
#set_property PACKAGE_PIN    AB27            [get_ports GTX_RX_Valid]
#set_property IOSTANDARD     LVCMOS33        [get_ports GTX_RX_Valid]





##---------- Set placement for gt0_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y4 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt0_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN T5 [get_ports {RXN_IN[0]}]
set_property PACKAGE_PIN T6 [get_ports {RXP_IN[0]}]
set_property PACKAGE_PIN P1 [get_ports {TXN_OUT[0]}]
set_property PACKAGE_PIN P2 [get_ports {TXP_OUT[0]}]
##---------- Set placement for gt1_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y6 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt1_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN P5 [get_ports {RXN_IN[1]}]
set_property PACKAGE_PIN P6 [get_ports {RXP_IN[1]}]
set_property PACKAGE_PIN M1 [get_ports {TXN_OUT[1]}]
set_property PACKAGE_PIN M2 [get_ports {TXP_OUT[1]}]
##---------- Set placement for gt2_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y8 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt2_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN K5 [get_ports {RXN_IN[2]}]
set_property PACKAGE_PIN K6 [get_ports {RXP_IN[2]}]
set_property PACKAGE_PIN K1 [get_ports {TXN_OUT[2]}]
set_property PACKAGE_PIN K2 [get_ports {TXP_OUT[2]}]
##---------- Set placement for gt3_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y9 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt3_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN H5 [get_ports {RXN_IN[3]}]
set_property PACKAGE_PIN H6 [get_ports {RXP_IN[3]}]
set_property PACKAGE_PIN J3 [get_ports {TXN_OUT[3]}]
set_property PACKAGE_PIN J4 [get_ports {TXP_OUT[3]}]
##---------- Set placement for gt4_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y12 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt4_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN E3 [get_ports {RXN_IN[4]}]
set_property PACKAGE_PIN E4 [get_ports {RXP_IN[4]}]
set_property PACKAGE_PIN D1 [get_ports {TXN_OUT[4]}]
set_property PACKAGE_PIN D2 [get_ports {TXP_OUT[4]}]
##---------- Set placement for gt5_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y13 [get_cells GTX_ROD_Datalink_inst/GTX_ROD_Link_support_i/GTX_ROD_Link_init_i/inst/GTX_ROD_Link_i/gt5_GTX_ROD_Link_i/gtxe2_i]
set_property PACKAGE_PIN D5 [get_ports {RXN_IN[5]}]
set_property PACKAGE_PIN D6 [get_ports {RXP_IN[5]}]
set_property PACKAGE_PIN C3 [get_ports {TXN_OUT[5]}]
set_property PACKAGE_PIN C4 [get_ports {TXP_OUT[5]}]

# Ehternet_10G ports
set_property PACKAGE_PIN R8 [get_ports ethernet_refclk_in_p]
set_property PACKAGE_PIN R7 [get_ports ethernet_refclk_in_n]

create_clock -period 6.400 [get_ports ethernet_refclk_in_p]

#set_property PACKAGE_PIN Y6 [get_ports SFP_rx_p]
#set_property PACKAGE_PIN Y5 [get_ports SFP_rx_n]
#set_property PACKAGE_PIN V2 [get_ports SFP_tx_p]
#set_property PACKAGE_PIN V1 [get_ports SFP_tx_n]

set_property PACKAGE_PIN AA3 [get_ports SFP_rx_n]
set_property PACKAGE_PIN AA4 [get_ports SFP_rx_p]
set_property PACKAGE_PIN Y1 [get_ports SFP_tx_n]
set_property PACKAGE_PIN Y2 [get_ports SFP_tx_p]

set_property PACKAGE_PIN AJ27 [get_ports SFP_tx0_disable]
set_property PACKAGE_PIN AH27 [get_ports SFP_tx1_disable]
set_property IOSTANDARD LVCMOS33 [get_ports SFP_tx0_disable]
set_property IOSTANDARD LVCMOS33 [get_ports SFP_tx1_disable]

#set_false_path -to [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *shared_clock_reset_block*sync1_r_reg[*]}] -filter {NAME =~ *PRE}]
#
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks ethernet_refclk_in_p]
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks ethernet_refclk_in_p]
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks ethernet_refclk_in_p]
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks ethernet_refclk_in_p]
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT3]]
#set_false_path -from [get_clocks -of_objects [get_pins clock_generator_inst/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks ethernet_refclk_in_p]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets ethernet_userclk]

set_property CONFIG_MODE SPIx4 [current_design]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
##connect_debug_port dbg_hub/clk [get_nets FEB6_GTX_RX_clk]
#connect_debug_port dbg_hub/clk [get_nets coreclk_out]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list Ethernet_10G_inst/fifo_block_i/ethernet_core_i/inst/xpcs/inst/ten_gig_eth_pcs_pma_shared_clock_reset_block/coreclk_out]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/op_code[0]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[1]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[2]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[3]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[4]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[5]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[6]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[7]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[8]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[9]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[10]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[11]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[12]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[13]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[14]} {Ethernet_10G_inst/arp_block/arp_parse/op_code[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 48 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/src_mac[0]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[1]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[2]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[3]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[4]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[5]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[6]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[7]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[8]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[9]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[10]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[11]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[12]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[13]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[14]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[15]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[16]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[17]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[18]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[19]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[20]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[21]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[22]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[23]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[24]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[25]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[26]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[27]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[28]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[29]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[30]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[31]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[32]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[33]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[34]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[35]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[36]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[37]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[38]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[39]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[40]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[41]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[42]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[43]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[44]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[45]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[46]} {Ethernet_10G_inst/arp_block/arp_parse/src_mac[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 48 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/des_mac[0]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[1]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[2]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[3]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[4]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[5]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[6]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[7]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[8]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[9]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[10]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[11]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[12]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[13]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[14]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[15]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[16]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[17]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[18]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[19]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[20]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[21]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[22]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[23]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[24]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[25]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[26]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[27]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[28]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[29]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[30]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[31]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[32]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[33]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[34]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[35]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[36]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[37]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[38]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[39]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[40]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[41]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[42]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[43]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[44]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[45]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[46]} {Ethernet_10G_inst/arp_block/arp_parse/des_mac[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/des_ip[0]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[1]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[2]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[3]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[4]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[5]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[6]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[7]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[8]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[9]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[10]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[11]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[12]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[13]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[14]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[15]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[16]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[17]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[18]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[19]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[20]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[21]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[22]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[23]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[24]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[25]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[26]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[27]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[28]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[29]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[30]} {Ethernet_10G_inst/arp_block/arp_parse/des_ip[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 16 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/rx_type[0]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[1]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[2]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[3]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[4]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[5]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[6]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[7]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[8]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[9]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[10]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[11]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[12]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[13]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[14]} {Ethernet_10G_inst/arp_block/arp_parse/rx_type[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {Ethernet_10G_inst/arp_block/arp_parse/src_ip[0]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[1]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[2]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[3]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[4]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[5]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[6]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[7]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[8]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[9]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[10]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[11]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[12]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[13]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[14]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[15]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[16]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[17]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[18]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[19]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[20]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[21]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[22]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[23]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[24]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[25]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[26]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[27]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[28]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[29]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[30]} {Ethernet_10G_inst/arp_block/arp_parse/src_ip[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list Ethernet_10G_inst/tcp_en]]
set_property C_CLK_INPUT_FREQ_HZ 100000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_coreclk_out]
#connect_debug_port dbg_hub/clk [get_nets clk_200M]