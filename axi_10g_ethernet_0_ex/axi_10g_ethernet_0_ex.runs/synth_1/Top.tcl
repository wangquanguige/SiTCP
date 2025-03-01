# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param tcl.collectionResultDisplayLimit 0
set_param chipscope.maxJobs 1
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7k325tffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.cache/wt [current_project]
set_property parent.project_path C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths c:/Users/123/Documents/xilinx_project/GitHub/Ethernet/ip_repo [current_project]
update_ip_catalog
set_property ip_output_repo c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/GTX_ROD_Datalink.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/GTX_ROD_Link_GT_USRCLK_SOURCE.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/GTX_ROD_Link_common.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/GTX_ROD_Link_common_reset.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/GTX_ROD_Link_support.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/PowerOnReset.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/RODlink_Data_Decode.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/RODlink_Data_Encode.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_block.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_control.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_generator.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_parser.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_reply.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_arp_request.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_axi_fifo.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_axi_lite_sm.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/axi_10g_ethernet_0_example_design.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_fifo_block.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_fifo_ram.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_sync_block.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_sync_reset.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_xgmac_fifo.v
  C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/new/Top.v
}
read_ip -quiet C:/Users/123/Documents/xilinx_project/STAR/STAR.srcs/sources_1/ip/GTX_ROD_Link/GTX_ROD_Link.xci
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/STAR/STAR.srcs/sources_1/ip/GTX_ROD_Link/GTX_ROD_Link.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/STAR/STAR.srcs/sources_1/ip/GTX_ROD_Link/GTX_ROD_Link_ooc.xdc]

read_ip -quiet C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/axi_10g_ethernet_0.xci
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_xmac_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_xpcs_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/bd_efdb_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/axi_10g_ethernet_0/synth/axi_10g_ethernet_0_ooc.xdc]

read_ip -quiet c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_example_design.xdc
set_property used_in_implementation false [get_files C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/imports/axi_10g_ethernet_0_example_design.xdc]

read_xdc C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/constrs_1/new/Top.xdc
set_property used_in_implementation false [get_files C:/Users/123/Documents/xilinx_project/SiTCP/axi_10g_ethernet_0_ex/axi_10g_ethernet_0_ex.srcs/constrs_1/new/Top.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Top -part xc7k325tffg900-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Top_utilization_synth.rpt -pb Top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
