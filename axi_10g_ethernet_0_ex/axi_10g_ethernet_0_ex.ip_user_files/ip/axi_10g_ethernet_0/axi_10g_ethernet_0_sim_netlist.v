// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Jan 22 11:08:32 2025
// Host        : DESKTOP-4V0BJ5M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top axi_10g_ethernet_0 -prefix
//               axi_10g_ethernet_0_ axi_10g_ethernet_0_sim_netlist.v
// Design      : axi_10g_ethernet_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "axi_10g_ethernet_0,bd_efdb,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "bd_efdb,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module axi_10g_ethernet_0
   (tx_axis_aresetn,
    rx_axis_aresetn,
    tx_ifg_delay,
    dclk,
    txp,
    txn,
    rxp,
    rxn,
    signal_detect,
    tx_fault,
    tx_disable,
    pcspma_status,
    sim_speedup_control,
    rxrecclk_out,
    s_axi_aclk,
    s_axi_aresetn,
    xgmacint,
    areset_datapathclk_out,
    txusrclk_out,
    txusrclk2_out,
    gttxreset_out,
    gtrxreset_out,
    txuserrdy_out,
    coreclk_out,
    resetdone_out,
    reset_counter_done_out,
    qplllock_out,
    qplloutclk_out,
    qplloutrefclk_out,
    refclk_p,
    refclk_n,
    reset,
    s_axi_araddr,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wvalid,
    s_axis_tx_tdata,
    s_axis_tx_tkeep,
    s_axis_tx_tlast,
    s_axis_tx_tready,
    s_axis_tx_tuser,
    s_axis_tx_tvalid,
    s_axis_pause_tdata,
    s_axis_pause_tvalid,
    m_axis_rx_tdata,
    m_axis_rx_tkeep,
    m_axis_rx_tlast,
    m_axis_rx_tuser,
    m_axis_rx_tvalid,
    tx_statistics_valid,
    tx_statistics_vector,
    rx_statistics_valid,
    rx_statistics_vector);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.tx_axis_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.tx_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input tx_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.rx_axis_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.rx_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rx_axis_aresetn;
  input [7:0]tx_ifg_delay;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.dclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.dclk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN bd_efdb_dclk, INSERT_VIP 0" *) input dclk;
  output txp;
  output txn;
  input rxp;
  input rxn;
  input signal_detect;
  input tx_fault;
  output tx_disable;
  output [7:0]pcspma_status;
  input sim_speedup_control;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.rxrecclk_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.rxrecclk_out, FREQ_HZ 322265625, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_rxrecclk_out, INSERT_VIP 0" *) output rxrecclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.s_axi_aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.s_axi_aclk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN bd_efdb_s_axi_aclk, ASSOCIATED_BUSIF s_axi, INSERT_VIP 0" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.s_axi_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.xgmacint INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.xgmacint, SENSITIVITY EDGE_RISING, PortWidth 1" *) output xgmacint;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.areset_datapathclk_out RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.areset_datapathclk_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output areset_datapathclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txusrclk_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txusrclk_out, FREQ_HZ 322265625, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_txusrclk_out, INSERT_VIP 0" *) output txusrclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txusrclk2_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txusrclk2_out, FREQ_HZ 322265625, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_txusrclk2_out, INSERT_VIP 0" *) output txusrclk2_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.gttxreset_out RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.gttxreset_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output gttxreset_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.gtrxreset_out RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.gtrxreset_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output gtrxreset_out;
  output txuserrdy_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.coreclk_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.coreclk_out, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, ASSOCIATED_BUSIF m_axis_rx:s_axis_pause:s_axis_tx, INSERT_VIP 0, ASSOCIATED_ASYNC_RESET tx_axis_aresetn:rx_axis_aresetn" *) output coreclk_out;
  output resetdone_out;
  output reset_counter_done_out;
  output qplllock_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.qplloutclk_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.qplloutclk_out, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_qplloutclk_out, INSERT_VIP 0" *) output qplloutclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.qplloutrefclk_out CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.qplloutrefclk_out, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_qplloutrefclk_out, INSERT_VIP 0" *) output qplloutrefclk_out;
  input refclk_p;
  input refclk_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.reset RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input reset;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [10:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [10:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 16, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN bd_efdb_s_axi_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TDATA" *) input [63:0]s_axis_tx_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TKEEP" *) input [7:0]s_axis_tx_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TLAST" *) input s_axis_tx_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TREADY" *) output s_axis_tx_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TUSER" *) input [0:0]s_axis_tx_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_tx, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_tx_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_pause TDATA" *) input [15:0]s_axis_pause_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_pause TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_pause, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_pause_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TDATA" *) output [63:0]m_axis_rx_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TKEEP" *) output [7:0]m_axis_rx_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TLAST" *) output m_axis_rx_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TUSER" *) output m_axis_rx_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_rx, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 156250000, PHASE 0.000, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_rx_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics valid" *) output tx_statistics_valid;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics vector" *) output [25:0]tx_statistics_vector;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics valid" *) output rx_statistics_valid;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics vector" *) output [29:0]rx_statistics_vector;

  wire areset_datapathclk_out;
  wire coreclk_out;
  wire dclk;
  wire gtrxreset_out;
  wire gttxreset_out;
  wire [63:0]m_axis_rx_tdata;
  wire [7:0]m_axis_rx_tkeep;
  wire m_axis_rx_tlast;
  wire m_axis_rx_tuser;
  wire m_axis_rx_tvalid;
  wire [7:0]pcspma_status;
  wire qplllock_out;
  wire qplloutclk_out;
  wire qplloutrefclk_out;
  wire refclk_n;
  wire refclk_p;
  wire reset;
  wire reset_counter_done_out;
  wire resetdone_out;
  wire rx_axis_aresetn;
  wire rx_statistics_valid;
  wire [29:0]rx_statistics_vector;
  wire rxn;
  wire rxp;
  wire rxrecclk_out;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [10:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire [15:0]s_axis_pause_tdata;
  wire s_axis_pause_tvalid;
  wire [63:0]s_axis_tx_tdata;
  wire [7:0]s_axis_tx_tkeep;
  wire s_axis_tx_tlast;
  wire s_axis_tx_tready;
  wire [0:0]s_axis_tx_tuser;
  wire s_axis_tx_tvalid;
  wire signal_detect;
  wire sim_speedup_control;
  wire tx_axis_aresetn;
  wire tx_disable;
  wire tx_fault;
  wire [7:0]tx_ifg_delay;
  wire tx_statistics_valid;
  wire [25:0]tx_statistics_vector;
  wire txn;
  wire txp;
  wire txuserrdy_out;
  wire txusrclk2_out;
  wire txusrclk_out;
  wire xgmacint;

  (* HW_HANDOFF = "axi_10g_ethernet_0.hwdef" *) 
  axi_10g_ethernet_0_bd_efdb inst
       (.areset_datapathclk_out(areset_datapathclk_out),
        .coreclk_out(coreclk_out),
        .dclk(dclk),
        .gtrxreset_out(gtrxreset_out),
        .gttxreset_out(gttxreset_out),
        .m_axis_rx_tdata(m_axis_rx_tdata),
        .m_axis_rx_tkeep(m_axis_rx_tkeep),
        .m_axis_rx_tlast(m_axis_rx_tlast),
        .m_axis_rx_tuser(m_axis_rx_tuser),
        .m_axis_rx_tvalid(m_axis_rx_tvalid),
        .pcspma_status(pcspma_status),
        .qplllock_out(qplllock_out),
        .qplloutclk_out(qplloutclk_out),
        .qplloutrefclk_out(qplloutrefclk_out),
        .refclk_n(refclk_n),
        .refclk_p(refclk_p),
        .reset(reset),
        .reset_counter_done_out(reset_counter_done_out),
        .resetdone_out(resetdone_out),
        .rx_axis_aresetn(rx_axis_aresetn),
        .rx_statistics_valid(rx_statistics_valid),
        .rx_statistics_vector(rx_statistics_vector),
        .rxn(rxn),
        .rxp(rxp),
        .rxrecclk_out(rxrecclk_out),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axis_pause_tdata(s_axis_pause_tdata),
        .s_axis_pause_tvalid(s_axis_pause_tvalid),
        .s_axis_tx_tdata(s_axis_tx_tdata),
        .s_axis_tx_tkeep(s_axis_tx_tkeep),
        .s_axis_tx_tlast(s_axis_tx_tlast),
        .s_axis_tx_tready(s_axis_tx_tready),
        .s_axis_tx_tuser(s_axis_tx_tuser),
        .s_axis_tx_tvalid(s_axis_tx_tvalid),
        .signal_detect(signal_detect),
        .sim_speedup_control(sim_speedup_control),
        .tx_axis_aresetn(tx_axis_aresetn),
        .tx_disable(tx_disable),
        .tx_fault(tx_fault),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector),
        .txn(txn),
        .txp(txp),
        .txuserrdy_out(txuserrdy_out),
        .txusrclk2_out(txusrclk2_out),
        .txusrclk_out(txusrclk_out),
        .xgmacint(xgmacint));
endmodule

(* HW_HANDOFF = "axi_10g_ethernet_0.hwdef" *) 
module axi_10g_ethernet_0_bd_efdb
   (areset_datapathclk_out,
    coreclk_out,
    dclk,
    gtrxreset_out,
    gttxreset_out,
    m_axis_rx_tdata,
    m_axis_rx_tkeep,
    m_axis_rx_tlast,
    m_axis_rx_tuser,
    m_axis_rx_tvalid,
    pcspma_status,
    qplllock_out,
    qplloutclk_out,
    qplloutrefclk_out,
    refclk_n,
    refclk_p,
    reset,
    reset_counter_done_out,
    resetdone_out,
    rx_axis_aresetn,
    rx_statistics_valid,
    rx_statistics_vector,
    rxn,
    rxp,
    rxrecclk_out,
    s_axi_aclk,
    s_axi_araddr,
    s_axi_aresetn,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wvalid,
    s_axis_pause_tdata,
    s_axis_pause_tvalid,
    s_axis_tx_tdata,
    s_axis_tx_tkeep,
    s_axis_tx_tlast,
    s_axis_tx_tready,
    s_axis_tx_tuser,
    s_axis_tx_tvalid,
    signal_detect,
    sim_speedup_control,
    tx_axis_aresetn,
    tx_disable,
    tx_fault,
    tx_ifg_delay,
    tx_statistics_valid,
    tx_statistics_vector,
    txn,
    txp,
    txuserrdy_out,
    txusrclk2_out,
    txusrclk_out,
    xgmacint);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESET_DATAPATHCLK_OUT RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESET_DATAPATHCLK_OUT, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) output areset_datapathclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CORECLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CORECLK_OUT, ASSOCIATED_ASYNC_RESET tx_axis_aresetn:rx_axis_aresetn, ASSOCIATED_BUSIF m_axis_rx:s_axis_pause:s_axis_tx, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, FREQ_HZ 156250000, INSERT_VIP 0, PHASE 0.000" *) output coreclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DCLK, CLK_DOMAIN bd_efdb_dclk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input dclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.GTRXRESET_OUT RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.GTRXRESET_OUT, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) output gtrxreset_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.GTTXRESET_OUT RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.GTTXRESET_OUT, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) output gttxreset_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_rx, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, FREQ_HZ 156250000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1" *) output [63:0]m_axis_rx_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TKEEP" *) output [7:0]m_axis_rx_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TLAST" *) output m_axis_rx_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TUSER" *) output m_axis_rx_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rx TVALID" *) output m_axis_rx_tvalid;
  output [7:0]pcspma_status;
  output qplllock_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.QPLLOUTCLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.QPLLOUTCLK_OUT, CLK_DOMAIN bd_efdb_xpcs_0_qplloutclk_out, FREQ_HZ 156250000, INSERT_VIP 0, PHASE 0.000" *) output qplloutclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.QPLLOUTREFCLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.QPLLOUTREFCLK_OUT, CLK_DOMAIN bd_efdb_xpcs_0_qplloutrefclk_out, FREQ_HZ 156250000, INSERT_VIP 0, PHASE 0.000" *) output qplloutrefclk_out;
  input refclk_n;
  input refclk_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset;
  output reset_counter_done_out;
  output resetdone_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RX_AXIS_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RX_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rx_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics valid" *) output rx_statistics_valid;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics vector" *) output [29:0]rx_statistics_vector;
  input rxn;
  input rxp;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.RXRECCLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.RXRECCLK_OUT, CLK_DOMAIN bd_efdb_xpcs_0_rxrecclk_out, FREQ_HZ 322265625, INSERT_VIP 0, PHASE 0.000" *) output rxrecclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXI_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXI_ACLK, ASSOCIATED_BUSIF s_axi, CLK_DOMAIN bd_efdb_s_axi_aclk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, ADDR_WIDTH 16, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN bd_efdb_s_axi_aclk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 0, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 0, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.000, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [10:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXI_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [10:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_pause TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_pause, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, FREQ_HZ 156250000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [15:0]s_axis_pause_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_pause TVALID" *) input s_axis_pause_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_tx, CLK_DOMAIN bd_efdb_xpcs_0_coreclk_out, FREQ_HZ 156250000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1" *) input [63:0]s_axis_tx_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TKEEP" *) input [7:0]s_axis_tx_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TLAST" *) input s_axis_tx_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TREADY" *) output s_axis_tx_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TUSER" *) input [0:0]s_axis_tx_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_tx TVALID" *) input s_axis_tx_tvalid;
  input signal_detect;
  input sim_speedup_control;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.TX_AXIS_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.TX_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input tx_axis_aresetn;
  output tx_disable;
  input tx_fault;
  input [7:0]tx_ifg_delay;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics valid" *) output tx_statistics_valid;
  (* X_INTERFACE_INFO = "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics vector" *) output [25:0]tx_statistics_vector;
  output txn;
  output txp;
  output txuserrdy_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.TXUSRCLK2_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.TXUSRCLK2_OUT, CLK_DOMAIN bd_efdb_xpcs_0_txusrclk2_out, FREQ_HZ 322265625, INSERT_VIP 0, PHASE 0.000" *) output txusrclk2_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.TXUSRCLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.TXUSRCLK_OUT, CLK_DOMAIN bd_efdb_xpcs_0_txusrclk_out, FREQ_HZ 322265625, INSERT_VIP 0, PHASE 0.000" *) output txusrclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.XGMACINT INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.XGMACINT, PortWidth 1, SENSITIVITY EDGE_RISING" *) output xgmacint;

  wire areset_datapathclk_out;
  wire coreclk_out;
  wire dclk;
  wire dcm_locked_driver_dout;
  wire gtrxreset_out;
  wire gttxreset_out;
  wire [63:0]m_axis_rx_tdata;
  wire [7:0]m_axis_rx_tkeep;
  wire m_axis_rx_tlast;
  wire m_axis_rx_tuser;
  wire m_axis_rx_tvalid;
  wire [7:0]pcspma_status;
  wire [2:0]pma_pmd_type_driver_dout;
  wire [4:0]prtad_driver_dout;
  wire qplllock_out;
  wire qplloutclk_out;
  wire qplloutrefclk_out;
  wire refclk_n;
  wire refclk_p;
  wire reset;
  wire reset_counter_done_out;
  wire resetdone_out;
  wire rx_axis_aresetn;
  wire rx_statistics_valid;
  wire [29:0]rx_statistics_vector;
  wire rxn;
  wire rxp;
  wire rxrecclk_out;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [10:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire [15:0]s_axis_pause_tdata;
  wire s_axis_pause_tvalid;
  wire [63:0]s_axis_tx_tdata;
  wire [7:0]s_axis_tx_tkeep;
  wire s_axis_tx_tlast;
  wire s_axis_tx_tready;
  wire [0:0]s_axis_tx_tuser;
  wire s_axis_tx_tvalid;
  wire signal_detect;
  wire sim_speedup_control;
  wire tx_axis_aresetn;
  wire tx_disable;
  wire tx_fault;
  wire [7:0]tx_ifg_delay;
  wire tx_statistics_valid;
  wire [25:0]tx_statistics_vector;
  wire txn;
  wire txp;
  wire txuserrdy_out;
  wire txusrclk2_out;
  wire txusrclk_out;
  wire xgmacint;
  wire xmac_mdio_xgmac_MDC;
  wire xmac_mdio_xgmac_MDIO_I;
  wire xmac_mdio_xgmac_MDIO_O;
  wire [7:0]xmac_xgmii_xgmac_RXC;
  wire [63:0]xmac_xgmii_xgmac_RXD;
  wire [7:0]xmac_xgmii_xgmac_TXC;
  wire [63:0]xmac_xgmii_xgmac_TXD;
  wire [15:0]xpcs_core_gt_drp_interface_DADDR;
  wire xpcs_core_gt_drp_interface_DEN;
  wire [15:0]xpcs_core_gt_drp_interface_DI;
  wire [15:0]xpcs_core_gt_drp_interface_DO;
  wire xpcs_core_gt_drp_interface_DRDY;
  wire xpcs_core_gt_drp_interface_DWE;
  wire xpcs_drp_req;
  wire NLW_xmac_mdio_tri_UNCONNECTED;
  wire NLW_xpcs_mdio_tri_UNCONNECTED;

  (* CHECK_LICENSE_TYPE = "bd_efdb_dcm_locked_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
  axi_10g_ethernet_0_bd_efdb_dcm_locked_driver_0 dcm_locked_driver
       (.dout(dcm_locked_driver_dout));
  (* CHECK_LICENSE_TYPE = "bd_efdb_pma_pmd_type_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
  axi_10g_ethernet_0_bd_efdb_pma_pmd_type_driver_0 pma_pmd_type_driver
       (.dout(pma_pmd_type_driver_dout));
  (* CHECK_LICENSE_TYPE = "bd_efdb_prtad_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
  axi_10g_ethernet_0_bd_efdb_prtad_driver_0 prtad_driver
       (.dout(prtad_driver_dout));
  (* X_CORE_INFO = "ten_gig_eth_mac_v15_1_7,Vivado 2019.2" *) 
  axi_10g_ethernet_0_bd_efdb_xmac_0 xmac
       (.mdc(xmac_mdio_xgmac_MDC),
        .mdio_in(xmac_mdio_xgmac_MDIO_I),
        .mdio_out(xmac_mdio_xgmac_MDIO_O),
        .mdio_tri(NLW_xmac_mdio_tri_UNCONNECTED),
        .pause_req(s_axis_pause_tvalid),
        .pause_val(s_axis_pause_tdata),
        .reset(reset),
        .rx_axis_aresetn(rx_axis_aresetn),
        .rx_axis_tdata(m_axis_rx_tdata),
        .rx_axis_tkeep(m_axis_rx_tkeep),
        .rx_axis_tlast(m_axis_rx_tlast),
        .rx_axis_tuser(m_axis_rx_tuser),
        .rx_axis_tvalid(m_axis_rx_tvalid),
        .rx_clk0(coreclk_out),
        .rx_dcm_locked(dcm_locked_driver_dout),
        .rx_statistics_valid(rx_statistics_valid),
        .rx_statistics_vector(rx_statistics_vector),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid),
        .tx_axis_aresetn(tx_axis_aresetn),
        .tx_axis_tdata(s_axis_tx_tdata),
        .tx_axis_tkeep(s_axis_tx_tkeep),
        .tx_axis_tlast(s_axis_tx_tlast),
        .tx_axis_tready(s_axis_tx_tready),
        .tx_axis_tuser(s_axis_tx_tuser),
        .tx_axis_tvalid(s_axis_tx_tvalid),
        .tx_clk0(coreclk_out),
        .tx_dcm_locked(dcm_locked_driver_dout),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector),
        .xgmacint(xgmacint),
        .xgmii_rxc(xmac_xgmii_xgmac_RXC),
        .xgmii_rxd(xmac_xgmii_xgmac_RXD),
        .xgmii_txc(xmac_xgmii_xgmac_TXC),
        .xgmii_txd(xmac_xgmii_xgmac_TXD));
  (* X_CORE_INFO = "ten_gig_eth_pcs_pma_v6_0_16,Vivado 2019.2" *) 
  axi_10g_ethernet_0_bd_efdb_xpcs_0 xpcs
       (.areset_datapathclk_out(areset_datapathclk_out),
        .core_status(pcspma_status),
        .coreclk_out(coreclk_out),
        .dclk(dclk),
        .drp_daddr_i(xpcs_core_gt_drp_interface_DADDR),
        .drp_daddr_o(xpcs_core_gt_drp_interface_DADDR),
        .drp_den_i(xpcs_core_gt_drp_interface_DEN),
        .drp_den_o(xpcs_core_gt_drp_interface_DEN),
        .drp_di_i(xpcs_core_gt_drp_interface_DI),
        .drp_di_o(xpcs_core_gt_drp_interface_DI),
        .drp_drdy_i(xpcs_core_gt_drp_interface_DRDY),
        .drp_drdy_o(xpcs_core_gt_drp_interface_DRDY),
        .drp_drpdo_i(xpcs_core_gt_drp_interface_DO),
        .drp_drpdo_o(xpcs_core_gt_drp_interface_DO),
        .drp_dwe_i(xpcs_core_gt_drp_interface_DWE),
        .drp_dwe_o(xpcs_core_gt_drp_interface_DWE),
        .drp_gnt(xpcs_drp_req),
        .drp_req(xpcs_drp_req),
        .gtrxreset_out(gtrxreset_out),
        .gttxreset_out(gttxreset_out),
        .mdc(xmac_mdio_xgmac_MDC),
        .mdio_in(xmac_mdio_xgmac_MDIO_O),
        .mdio_out(xmac_mdio_xgmac_MDIO_I),
        .mdio_tri(NLW_xpcs_mdio_tri_UNCONNECTED),
        .pma_pmd_type(pma_pmd_type_driver_dout),
        .prtad(prtad_driver_dout),
        .qplllock_out(qplllock_out),
        .qplloutclk_out(qplloutclk_out),
        .qplloutrefclk_out(qplloutrefclk_out),
        .refclk_n(refclk_n),
        .refclk_p(refclk_p),
        .reset(reset),
        .reset_counter_done_out(reset_counter_done_out),
        .resetdone_out(resetdone_out),
        .rxn(rxn),
        .rxp(rxp),
        .rxrecclk_out(rxrecclk_out),
        .signal_detect(signal_detect),
        .sim_speedup_control(sim_speedup_control),
        .tx_disable(tx_disable),
        .tx_fault(tx_fault),
        .txn(txn),
        .txp(txp),
        .txuserrdy_out(txuserrdy_out),
        .txusrclk2_out(txusrclk2_out),
        .txusrclk_out(txusrclk_out),
        .xgmii_rxc(xmac_xgmii_xgmac_RXC),
        .xgmii_rxd(xmac_xgmii_xgmac_RXD),
        .xgmii_txc(xmac_xgmii_xgmac_TXC),
        .xgmii_txd(xmac_xgmii_xgmac_TXD));
endmodule

(* CHECK_LICENSE_TYPE = "bd_efdb_dcm_locked_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
module axi_10g_ethernet_0_bd_efdb_dcm_locked_driver_0
   (dout);
  output [0:0]dout;

  wire \<const1> ;

  assign dout[0] = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
endmodule

(* CHECK_LICENSE_TYPE = "bd_efdb_pma_pmd_type_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
module axi_10g_ethernet_0_bd_efdb_pma_pmd_type_driver_0
   (dout);
  output [2:0]dout;

  wire \<const0> ;
  wire \<const1> ;

  assign dout[2] = \<const1> ;
  assign dout[1] = \<const0> ;
  assign dout[0] = \<const1> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
endmodule

(* CHECK_LICENSE_TYPE = "bd_efdb_prtad_driver_0,xlconstant_v1_1_6_xlconstant,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "xlconstant_v1_1_6_xlconstant,Vivado 2019.2" *) 
module axi_10g_ethernet_0_bd_efdb_prtad_driver_0
   (dout);
  output [4:0]dout;

  wire \<const0> ;

  assign dout[4] = \<const0> ;
  assign dout[3] = \<const0> ;
  assign dout[2] = \<const0> ;
  assign dout[1] = \<const0> ;
  assign dout[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
endmodule

(* X_CORE_INFO = "ten_gig_eth_mac_v15_1_7,Vivado 2019.2" *) 
module axi_10g_ethernet_0_bd_efdb_xmac_0
   (tx_clk0,
    reset,
    tx_axis_aresetn,
    tx_axis_tdata,
    tx_axis_tkeep,
    tx_axis_tvalid,
    tx_axis_tlast,
    tx_axis_tuser,
    tx_ifg_delay,
    tx_axis_tready,
    tx_statistics_vector,
    tx_statistics_valid,
    pause_val,
    pause_req,
    rx_axis_aresetn,
    rx_axis_tdata,
    rx_axis_tkeep,
    rx_axis_tvalid,
    rx_axis_tuser,
    rx_axis_tlast,
    rx_statistics_vector,
    rx_statistics_valid,
    s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    xgmacint,
    mdc,
    mdio_in,
    mdio_out,
    mdio_tri,
    tx_dcm_locked,
    xgmii_txd,
    xgmii_txc,
    rx_clk0,
    rx_dcm_locked,
    xgmii_rxd,
    xgmii_rxc);
  input tx_clk0;
  input reset;
  input tx_axis_aresetn;
  input [63:0]tx_axis_tdata;
  input [7:0]tx_axis_tkeep;
  input tx_axis_tvalid;
  input tx_axis_tlast;
  input tx_axis_tuser;
  input [7:0]tx_ifg_delay;
  output tx_axis_tready;
  output [25:0]tx_statistics_vector;
  output tx_statistics_valid;
  input [15:0]pause_val;
  input pause_req;
  input rx_axis_aresetn;
  output [63:0]rx_axis_tdata;
  output [7:0]rx_axis_tkeep;
  output rx_axis_tvalid;
  output rx_axis_tuser;
  output rx_axis_tlast;
  output [29:0]rx_statistics_vector;
  output rx_statistics_valid;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [10:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [10:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  output xgmacint;
  output mdc;
  input mdio_in;
  output mdio_out;
  output mdio_tri;
  input tx_dcm_locked;
  output [63:0]xgmii_txd;
  output [7:0]xgmii_txc;
  input rx_clk0;
  input rx_dcm_locked;
  input [63:0]xgmii_rxd;
  input [7:0]xgmii_rxc;


endmodule

(* X_CORE_INFO = "ten_gig_eth_pcs_pma_v6_0_16,Vivado 2019.2" *) 
module axi_10g_ethernet_0_bd_efdb_xpcs_0
   (dclk,
    rxrecclk_out,
    refclk_p,
    refclk_n,
    sim_speedup_control,
    coreclk_out,
    qplloutclk_out,
    qplloutrefclk_out,
    qplllock_out,
    txusrclk_out,
    txusrclk2_out,
    areset_datapathclk_out,
    gttxreset_out,
    gtrxreset_out,
    txuserrdy_out,
    reset_counter_done_out,
    reset,
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    txp,
    txn,
    rxp,
    rxn,
    mdc,
    mdio_in,
    mdio_out,
    mdio_tri,
    prtad,
    core_status,
    resetdone_out,
    signal_detect,
    tx_fault,
    drp_req,
    drp_gnt,
    drp_den_o,
    drp_dwe_o,
    drp_daddr_o,
    drp_di_o,
    drp_drdy_o,
    drp_drpdo_o,
    drp_den_i,
    drp_dwe_i,
    drp_daddr_i,
    drp_di_i,
    drp_drdy_i,
    drp_drpdo_i,
    pma_pmd_type,
    tx_disable);
  input dclk;
  output rxrecclk_out;
  input refclk_p;
  input refclk_n;
  input sim_speedup_control;
  output coreclk_out;
  output qplloutclk_out;
  output qplloutrefclk_out;
  output qplllock_out;
  output txusrclk_out;
  output txusrclk2_out;
  output areset_datapathclk_out;
  output gttxreset_out;
  output gtrxreset_out;
  output txuserrdy_out;
  output reset_counter_done_out;
  input reset;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output txp;
  output txn;
  input rxp;
  input rxn;
  input mdc;
  input mdio_in;
  output mdio_out;
  output mdio_tri;
  input [4:0]prtad;
  output [7:0]core_status;
  output resetdone_out;
  input signal_detect;
  input tx_fault;
  output drp_req;
  input drp_gnt;
  output drp_den_o;
  output drp_dwe_o;
  output [15:0]drp_daddr_o;
  output [15:0]drp_di_o;
  output drp_drdy_o;
  output [15:0]drp_drpdo_o;
  input drp_den_i;
  input drp_dwe_i;
  input [15:0]drp_daddr_i;
  input [15:0]drp_di_i;
  input drp_drdy_i;
  input [15:0]drp_drpdo_i;
  input [2:0]pma_pmd_type;
  output tx_disable;


endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
