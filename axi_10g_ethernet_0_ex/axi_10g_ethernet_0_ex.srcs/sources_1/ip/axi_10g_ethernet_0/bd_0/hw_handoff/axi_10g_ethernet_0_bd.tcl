
################################################################
# This is a generated script based on design: bd_efdb_0
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source bd_efdb_0_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcku060-ffva1156-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name bd_efdb_0

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ./axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir -bdsource SBD $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design -bdsource SBD $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set m_axis_rx [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_rx ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $m_axis_rx

  set rx_statistics [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_ten_gig_eth_mac:statistics_rtl:2.0 rx_statistics ]

  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {16} \
   ] $s_axi

  set s_axis_pause [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_pause ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $s_axis_pause

  set s_axis_tx [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $s_axis_tx

  set tx_statistics [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_ten_gig_eth_mac:statistics_rtl:2.0 tx_statistics ]


  # Create ports
  set areset_coreclk_out [ create_bd_port -dir O -type rst areset_coreclk_out ]
  set areset_datapathclk_out [ create_bd_port -dir O -type rst areset_datapathclk_out ]
  set coreclk_out [ create_bd_port -dir O -type clk coreclk_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
 ] $coreclk_out
  set dclk [ create_bd_port -dir I -type clk dclk ]
  set gtrxreset_out [ create_bd_port -dir O -type rst gtrxreset_out ]
  set gttxreset_out [ create_bd_port -dir O -type rst gttxreset_out ]
  set pcspma_status [ create_bd_port -dir O -from 7 -to 0 pcspma_status ]
  set qpll0lock_out [ create_bd_port -dir O qpll0lock_out ]
  set qpll0outclk_out [ create_bd_port -dir O -type clk qpll0outclk_out ]
  set qpll0outrefclk_out [ create_bd_port -dir O -type clk qpll0outrefclk_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
 ] $qpll0outrefclk_out
  set refclk_n [ create_bd_port -dir I refclk_n ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
 ] $refclk_n
  set refclk_p [ create_bd_port -dir I refclk_p ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
 ] $refclk_p
  set reset [ create_bd_port -dir I -type rst reset ]
  set reset_counter_done_out [ create_bd_port -dir O reset_counter_done_out ]
  set resetdone_out [ create_bd_port -dir O resetdone_out ]
  set rx_axis_aresetn [ create_bd_port -dir I -type rst rx_axis_aresetn ]
  set rxn [ create_bd_port -dir I rxn ]
  set rxp [ create_bd_port -dir I rxp ]
  set rxrecclk_out [ create_bd_port -dir O -type clk rxrecclk_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
 ] $rxrecclk_out
  set s_axi_aclk [ create_bd_port -dir I -type clk s_axi_aclk ]
  set s_axi_aresetn [ create_bd_port -dir I -type rst s_axi_aresetn ]
  set signal_detect [ create_bd_port -dir I signal_detect ]
  set sim_speedup_control [ create_bd_port -dir I sim_speedup_control ]
  set tx_axis_aresetn [ create_bd_port -dir I -type rst tx_axis_aresetn ]
  set tx_disable [ create_bd_port -dir O tx_disable ]
  set tx_fault [ create_bd_port -dir I tx_fault ]
  set tx_ifg_delay [ create_bd_port -dir I -from 7 -to 0 tx_ifg_delay ]
  set txn [ create_bd_port -dir O txn ]
  set txp [ create_bd_port -dir O txp ]
  set txuserrdy_out [ create_bd_port -dir O txuserrdy_out ]
  set txusrclk2_out [ create_bd_port -dir O -type clk txusrclk2_out ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_ASYNC_RESET {tx_axis_aresetn:rx_axis_aresetn} \
   CONFIG.ASSOCIATED_BUSIF {m_axis_rx:s_axis_pause:s_axis_tx} \
   CONFIG.FREQ_HZ {156250000} \
 ] $txusrclk2_out
  set txusrclk_out [ create_bd_port -dir O -type clk txusrclk_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {312500000} \
 ] $txusrclk_out
  set xgmacint [ create_bd_port -dir O -type intr xgmacint ]

  # Create instance: dcm_locked_driver, and set properties
  set dcm_locked_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 dcm_locked_driver ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $dcm_locked_driver

  # Create instance: pma_pmd_type_driver, and set properties
  set pma_pmd_type_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 pma_pmd_type_driver ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {5} \
   CONFIG.CONST_WIDTH {3} \
 ] $pma_pmd_type_driver

  # Create instance: prtad_driver, and set properties
  set prtad_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 prtad_driver ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {5} \
 ] $prtad_driver

  # Create instance: xmac, and set properties
  set xmac [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_mac:15.1 xmac ]
  set_property -dict [ list \
   CONFIG.Data_Rate {10Gbps} \
   CONFIG.Enable_Priority_Flow_Control {false} \
   CONFIG.IEEE_1588 {None} \
   CONFIG.Low_Latency_32_bit_MAC {64bit} \
   CONFIG.Management_Frequency {100.00} \
   CONFIG.Management_Interface {true} \
   CONFIG.Physical_Interface {Internal} \
   CONFIG.Statistics_Gathering {false} \
   CONFIG.Timer_Format {Time_of_day} \
   CONFIG.gt_type {GTHE3} \
 ] $xmac

  # Create instance: xpcs, and set properties
  set xpcs [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_pcs_pma:6.0 xpcs ]
  set_property -dict [ list \
   CONFIG.DClkRate {100.00} \
   CONFIG.IEEE_1588 {None} \
   CONFIG.Locations {X0Y12} \
   CONFIG.MDIO_Management {true} \
   CONFIG.RefClk {clk0} \
   CONFIG.RefClkRate {156.25} \
   CONFIG.SupportLevel {1} \
   CONFIG.Timer_Format {Time_of_day} \
   CONFIG.TransceiverControl {false} \
   CONFIG.TransceiverInExample {false} \
   CONFIG.autonegotiation {false} \
   CONFIG.base_kr {BASE-R} \
   CONFIG.baser32 {64bit} \
   CONFIG.fec {false} \
   CONFIG.no_ebuff {false} \
   CONFIG.speed10_25 {10Gig} \
   CONFIG.vu_gt_type {GTH} \
 ] $xpcs

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_ports s_axi] [get_bd_intf_pins xmac/s_axi]
  connect_bd_intf_net -intf_net s_axis_pause_1 [get_bd_intf_ports s_axis_pause] [get_bd_intf_pins xmac/s_axis_pause]
  connect_bd_intf_net -intf_net s_axis_tx_1 [get_bd_intf_ports s_axis_tx] [get_bd_intf_pins xmac/s_axis_tx]
  connect_bd_intf_net -intf_net xmac_m_axis_rx [get_bd_intf_ports m_axis_rx] [get_bd_intf_pins xmac/m_axis_rx]
  connect_bd_intf_net -intf_net xmac_mdio_xgmac [get_bd_intf_pins xmac/mdio_xgmac] [get_bd_intf_pins xpcs/mdio_interface]
  connect_bd_intf_net -intf_net xmac_rx_statistics [get_bd_intf_ports rx_statistics] [get_bd_intf_pins xmac/rx_statistics]
  connect_bd_intf_net -intf_net xmac_tx_statistics [get_bd_intf_ports tx_statistics] [get_bd_intf_pins xmac/tx_statistics]
  connect_bd_intf_net -intf_net xmac_xgmii_xgmac [get_bd_intf_pins xmac/xgmii_xgmac] [get_bd_intf_pins xpcs/xgmii_interface]
  connect_bd_intf_net -intf_net xpcs_core_to_gt_drp [get_bd_intf_pins xpcs/core_to_gt_drp] [get_bd_intf_pins xpcs/gt_drp]

  # Create port connections
  connect_bd_net -net dclk_1 [get_bd_ports dclk] [get_bd_pins xpcs/dclk]
  connect_bd_net -net dcm_locked_driver_dout [get_bd_pins dcm_locked_driver/dout] [get_bd_pins xmac/rx_dcm_locked] [get_bd_pins xmac/tx_dcm_locked]
  connect_bd_net -net pma_pmd_type_driver_dout [get_bd_pins pma_pmd_type_driver/dout] [get_bd_pins xpcs/pma_pmd_type]
  connect_bd_net -net prtad_driver_dout [get_bd_pins prtad_driver/dout] [get_bd_pins xpcs/prtad]
  connect_bd_net -net refclk_n_1 [get_bd_ports refclk_n] [get_bd_pins xpcs/refclk_n]
  connect_bd_net -net refclk_p_1 [get_bd_ports refclk_p] [get_bd_pins xpcs/refclk_p]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins xmac/reset] [get_bd_pins xpcs/reset]
  connect_bd_net -net rx_axis_aresetn_1 [get_bd_ports rx_axis_aresetn] [get_bd_pins xmac/rx_axis_aresetn]
  connect_bd_net -net rxn_1 [get_bd_ports rxn] [get_bd_pins xpcs/rxn]
  connect_bd_net -net rxp_1 [get_bd_ports rxp] [get_bd_pins xpcs/rxp]
  connect_bd_net -net s_axi_aclk_1 [get_bd_ports s_axi_aclk] [get_bd_pins xmac/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_ports s_axi_aresetn] [get_bd_pins xmac/s_axi_aresetn]
  connect_bd_net -net signal_detect_1 [get_bd_ports signal_detect] [get_bd_pins xpcs/signal_detect]
  connect_bd_net -net sim_speedup_control_1 [get_bd_ports sim_speedup_control] [get_bd_pins xpcs/sim_speedup_control]
  connect_bd_net -net tx_axis_aresetn_1 [get_bd_ports tx_axis_aresetn] [get_bd_pins xmac/tx_axis_aresetn]
  connect_bd_net -net tx_fault_1 [get_bd_ports tx_fault] [get_bd_pins xpcs/tx_fault]
  connect_bd_net -net tx_ifg_delay_1 [get_bd_ports tx_ifg_delay] [get_bd_pins xmac/tx_ifg_delay]
  connect_bd_net -net xmac_xgmacint [get_bd_ports xgmacint] [get_bd_pins xmac/xgmacint]
  connect_bd_net -net xpcs_areset_coreclk_out [get_bd_ports areset_coreclk_out] [get_bd_pins xpcs/areset_coreclk_out]
  connect_bd_net -net xpcs_areset_datapathclk_out [get_bd_ports areset_datapathclk_out] [get_bd_pins xpcs/areset_datapathclk_out]
  connect_bd_net -net xpcs_core_status [get_bd_ports pcspma_status] [get_bd_pins xpcs/core_status]
  connect_bd_net -net xpcs_coreclk_out [get_bd_ports coreclk_out] [get_bd_pins xpcs/coreclk_out]
  connect_bd_net -net xpcs_drp_req [get_bd_pins xpcs/drp_gnt] [get_bd_pins xpcs/drp_req]
  connect_bd_net -net xpcs_gtrxreset_out [get_bd_ports gtrxreset_out] [get_bd_pins xpcs/gtrxreset_out]
  connect_bd_net -net xpcs_gttxreset_out [get_bd_ports gttxreset_out] [get_bd_pins xpcs/gttxreset_out]
  connect_bd_net -net xpcs_qpll0lock_out [get_bd_ports qpll0lock_out] [get_bd_pins xpcs/qpll0lock_out]
  connect_bd_net -net xpcs_qpll0outclk_out [get_bd_ports qpll0outclk_out] [get_bd_pins xpcs/qpll0outclk_out]
  connect_bd_net -net xpcs_qpll0outrefclk_out [get_bd_ports qpll0outrefclk_out] [get_bd_pins xpcs/qpll0outrefclk_out]
  connect_bd_net -net xpcs_reset_counter_done_out [get_bd_ports reset_counter_done_out] [get_bd_pins xpcs/reset_counter_done_out]
  connect_bd_net -net xpcs_resetdone_out [get_bd_ports resetdone_out] [get_bd_pins xpcs/resetdone_out]
  connect_bd_net -net xpcs_rxrecclk_out [get_bd_ports rxrecclk_out] [get_bd_pins xpcs/rxrecclk_out]
  connect_bd_net -net xpcs_tx_disable [get_bd_ports tx_disable] [get_bd_pins xpcs/tx_disable]
  connect_bd_net -net xpcs_txn [get_bd_ports txn] [get_bd_pins xpcs/txn]
  connect_bd_net -net xpcs_txp [get_bd_ports txp] [get_bd_pins xpcs/txp]
  connect_bd_net -net xpcs_txuserrdy_out [get_bd_ports txuserrdy_out] [get_bd_pins xpcs/txuserrdy_out]
  connect_bd_net -net xpcs_txusrclk2_out [get_bd_ports txusrclk2_out] [get_bd_pins xmac/rx_clk0] [get_bd_pins xmac/tx_clk0] [get_bd_pins xpcs/txusrclk2_out]
  connect_bd_net -net xpcs_txusrclk_out [get_bd_ports txusrclk_out] [get_bd_pins xpcs/txusrclk_out]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs xmac/s_axi/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


