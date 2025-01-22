`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/22 10:11:47
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
// Clock
input   wire        CLK_OnBoard_p,                      // 200MHz
input   wire        CLK_OnBoard_n,

// Ethernet_10G
input   wire        ethernet_refclk_in_p,               // 156.25MHz
input   wire        ethernet_refclk_in_n,

output  wire        SFP_tx_p,
output  wire        SFP_tx_n,
input   wire        SFP_rx_p,
input   wire        SFP_rx_n,
output  wire        SFP_tx0_disable,
output  wire        SFP_tx1_disable,

// JTAG
output  ROD_TDO,
input   ROD_TDI,
input   ROD_TMS,
input   ROD_TCK,

input   FEB_TDO,
output  FEB_TDI,
output  FEB_TMS,
output  FEB_TCK,

// FEB_ROD Datalink
output  wire        ROD_CMD_FEB1_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB1_n,
input   wire        FEB1_Response_p,                    // receive FEB response 
input   wire        FEB1_Response_n,

output  wire        ROD_CMD_FEB2_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB2_n,
input   wire        FEB2_Response_p,                    // receive FEB response 
input   wire        FEB2_Response_n,

output  wire        ROD_CMD_FEB3_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB3_n,
input   wire        FEB3_Response_p,                    // receive FEB response 
input   wire        FEB3_Response_n,

output  wire        ROD_CMD_FEB4_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB4_n,
input   wire        FEB4_Response_p,                    // receive FEB response 
input   wire        FEB4_Response_n,

output  wire        ROD_CMD_FEB5_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB5_n,
input   wire        FEB5_Response_p,                    // receive FEB response 
input   wire        FEB5_Response_n,

output  wire        ROD_CMD_FEB6_p,                     // output commads to FEB
output  wire        ROD_CMD_FEB6_n,
input   wire        FEB6_Response_p,                    // receive FEB response 
input   wire        FEB6_Response_n,

// Clock for FEB                                    // distribute synchronization clock for FEB
output  wire        FEB1_clk_p,
output  wire        FEB1_clk_n,
output  wire        FEB2_clk_p,
output  wire        FEB2_clk_n,
output  wire        FEB3_clk_p,
output  wire        FEB3_clk_n,
output  wire        FEB4_clk_p,
output  wire        FEB4_clk_n,
output  wire        FEB5_clk_p,
output  wire        FEB5_clk_n,
output  wire        FEB6_clk_p,
output  wire        FEB6_clk_n,

// External Trigger
input   wire    External_Trigger,

// Trigger for FEB
output  wire        Trigger_FEB1_p,
output  wire        Trigger_FEB1_n,
output  wire        Trigger_FEB2_p,
output  wire        Trigger_FEB2_n,
output  wire        Trigger_FEB3_p,
output  wire        Trigger_FEB3_n,
output  wire        Trigger_FEB4_p,
output  wire        Trigger_FEB4_n,
output  wire        Trigger_FEB5_p,
output  wire        Trigger_FEB5_n,
output  wire        Trigger_FEB6_p,
output  wire        Trigger_FEB6_n,

// GTX
input   wire        Q2_CLK0_GTREFCLK_PAD_P_IN,          // GTX reference clock, 200MHz
input   wire        Q2_CLK0_GTREFCLK_PAD_N_IN,
input   wire [5:0]  RXP_IN,                             // receive VMM data from FEB
input   wire [5:0]  RXN_IN,
output  wire [5:0]  TXP_OUT,                           
output  wire [5:0]  TXN_OUT

// debug
//output  wire    GTX_RX_Valid

    );
      

//------------------------------ System Clock ------------------------------//
wire clk_40M,clk_100M,clk_200M,s_axi_aclk;    
clk_wiz_0   clock_generator_inst
(
.clk_out1   (clk_40M),
.clk_out2   (clk_100M),
.clk_out3   (clk_200M),
.clk_out4   (s_axi_aclk),           // 125MHz
.clk_in1_p  (CLK_OnBoard_p),
.clk_in1_n  (CLK_OnBoard_n)
);       
  
  
// JTAG
//reg FEB_TDI_r = 1'b0;
//reg FEB_TMS_r = 1'b0;
//reg FEB_TCK_r = 1'b0;

//always@(posedge clk_200M)
//    begin
//        FEB_TDI_r   <= ROD_TDI;
//        FEB_TMS_r   <= ROD_TMS;
//        FEB_TCK_r   <= ROD_TCK;
//    end

assign ROD_TDO = FEB_TDO; 
assign FEB_TDI = ROD_TDI; 
assign FEB_TMS = ROD_TMS; 
assign FEB_TCK = ROD_TCK;     

//OBUF    OBUF_FEB_TDI
//(
//    .I(ROD_TDI),
//    .O(FEB_TDI)
//);

//OBUF    OBUF_FEB_TMS
//(
//    .I(ROD_TMS),
//    .O(FEB_TMS)
//);

//OBUF    OBUF_FEB_TCK
//(
//    .I(ROD_TCK),
//    .O(FEB_TCK)
//);

//------------------------------ Power On Reset ------------------------------//
wire reset;
PowerOnReset    PowerOnReset_inst
(
.clk    (clk_40M),
.reset  (reset)
);    


//------------------------------ FEB clock ------------------------------//
OBUFDS OBUFDS_FEB1_clk (
	.O(FEB1_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB1_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  

OBUFDS OBUFDS_FEB2_clk (
	.O(FEB2_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB2_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  

OBUFDS OBUFDS_FEB3_clk (
	.O(FEB3_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB3_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  

OBUFDS OBUFDS_FEB4_clk (
	.O(FEB4_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB4_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  

OBUFDS OBUFDS_FEB5_clk (
	.O(FEB5_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB5_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  

OBUFDS OBUFDS_FEB6_clk (
	.O(FEB6_clk_p),     // Diff_p output (connect directly to top-level port)
	.OB(FEB6_clk_n),   // Diff_n output (connect directly to top-level port)
	.I(clk_40M)      // Buffer input 
);  


//------------------------------ GTX  ------------------------------// 
wire [31:0] FEB1_GTX_RX_data,FEB2_GTX_RX_data,FEB3_GTX_RX_data,FEB4_GTX_RX_data,FEB5_GTX_RX_data,FEB6_GTX_RX_data;
wire        FEB1_GTX_RX_valid,FEB1_GTX_RX_CRC,FEB1_GTX_RX_clk;
wire        FEB2_GTX_RX_valid,FEB2_GTX_RX_CRC,FEB2_GTX_RX_clk;
wire        FEB3_GTX_RX_valid,FEB3_GTX_RX_CRC,FEB3_GTX_RX_clk;
wire        FEB4_GTX_RX_valid,FEB4_GTX_RX_CRC,FEB4_GTX_RX_clk;
wire        FEB5_GTX_RX_valid,FEB5_GTX_RX_CRC,FEB5_GTX_RX_clk;
wire        FEB6_GTX_RX_valid,FEB6_GTX_RX_CRC,FEB6_GTX_RX_clk;
GTX_ROD_Datalink    GTX_ROD_Datalink_inst
(
.reset                      (reset),
.Q2_CLK0_GTREFCLK_PAD_N_IN  (Q2_CLK0_GTREFCLK_PAD_N_IN),
.Q2_CLK0_GTREFCLK_PAD_P_IN  (Q2_CLK0_GTREFCLK_PAD_P_IN),
.DRPCLK_IN                  (clk_100M),
.RXN_IN                     (RXN_IN),
.RXP_IN                     (RXP_IN),
.TXN_OUT                    (TXN_OUT),
.TXP_OUT                    (TXP_OUT),
.FEB1_GTX_RX_data           (FEB1_GTX_RX_data),
.FEB1_GTX_RX_valid          (FEB1_GTX_RX_valid),
.FEB1_GTX_RX_CRC            (FEB1_GTX_RX_CRC),
.FEB1_GTX_RX_clk            (FEB1_GTX_RX_clk),
.FEB2_GTX_RX_data           (FEB2_GTX_RX_data),
.FEB2_GTX_RX_valid          (FEB2_GTX_RX_valid),
.FEB2_GTX_RX_CRC            (FEB2_GTX_RX_CRC),
.FEB2_GTX_RX_clk            (FEB2_GTX_RX_clk),
.FEB3_GTX_RX_data           (FEB3_GTX_RX_data),
.FEB3_GTX_RX_valid          (FEB3_GTX_RX_valid),
.FEB3_GTX_RX_CRC            (FEB3_GTX_RX_CRC),
.FEB3_GTX_RX_clk            (FEB3_GTX_RX_clk),
.FEB4_GTX_RX_data           (FEB4_GTX_RX_data),
.FEB4_GTX_RX_valid          (FEB4_GTX_RX_valid),
.FEB4_GTX_RX_CRC            (FEB4_GTX_RX_CRC),
.FEB4_GTX_RX_clk            (FEB4_GTX_RX_clk),
.FEB5_GTX_RX_data           (FEB5_GTX_RX_data),
.FEB5_GTX_RX_valid          (FEB5_GTX_RX_valid),
.FEB5_GTX_RX_CRC            (FEB5_GTX_RX_CRC),
.FEB5_GTX_RX_clk            (FEB5_GTX_RX_clk),
.FEB6_GTX_RX_data           (FEB6_GTX_RX_data),
.FEB6_GTX_RX_valid          (FEB6_GTX_RX_valid),
.FEB6_GTX_RX_CRC            (FEB6_GTX_RX_CRC),
.FEB6_GTX_RX_clk            (FEB6_GTX_RX_clk)
);  

// debug
//assign GTX_RX_Valid = FEB1_GTX_RX_valid||FEB2_GTX_RX_valid||FEB3_GTX_RX_valid||FEB4_GTX_RX_valid||FEB5_GTX_RX_valid||FEB6_GTX_RX_valid;
 
//------------------------------ Ethernet_10G  ------------------------------// 
wire            ethernet_userclk;
wire            ethernet_corerdy;
wire    [63:0]  ethernet_tx_data;
wire    [7:0]   ethernet_tx_keep;
wire            ethernet_tx_valid;
wire            ethernet_tx_last;
wire            ethernet_tx_ready;
wire    [63:0]  ethernet_rx_data;
wire    [7:0]   ethernet_rx_keep;
wire            ethernet_rx_valid;
wire            ethernet_rx_last;
wire            ethernet_rx_ready;

axi_10g_ethernet_0_example_design    Ethernet_10G_inst   (
.reset                  (reset),
.s_axi_aclk             (s_axi_aclk),               // Freerunning clock source
.refclk_p               (ethernet_refclk_in_p),     // Transcevier reference clock source
.refclk_n               (ethernet_refclk_in_n),
.userclk_out            (ethernet_userclk),
.tx_axis_tready         (ethernet_tx_ready),
.tx_axis_tdata          (ethernet_tx_data),
.tx_axis_tkeep          (ethernet_tx_keep),
.tx_axis_tlast          (ethernet_tx_last),
.tx_axis_tvalid         (ethernet_tx_valid),
.rx_axis_tdata          (ethernet_rx_data),
.rx_axis_tkeep          (ethernet_rx_keep),
.rx_axis_tvalid         (ethernet_rx_valid),
.rx_axis_tlast          (ethernet_rx_last),
.rx_axis_tready         (ethernet_rx_ready),
.core_ready             (ethernet_corerdy),
.txp                    (SFP_tx_p),
.txn                    (SFP_tx_n),
.rxp                    (SFP_rx_p),
.rxn                    (SFP_rx_n)
    );
  
assign SFP_tx0_disable = 1'b1;  
assign SFP_tx1_disable = 1'b1;    


//------------------------------ FEB ROD Host Communication ------------------------------//
wire    ROD_command_FEB1,ROD_command_FEB2,ROD_command_FEB3,ROD_command_FEB4,ROD_command_FEB5,ROD_command_FEB6;
wire    Trigger_FEB1_o,Trigger_FEB2_o,Trigger_FEB3_o,Trigger_FEB4_o,Trigger_FEB5_o,Trigger_FEB6_o;
wire    FEB1_Response_i,FEB2_Response_i,FEB3_Response_i,FEB4_Response_i,FEB5_Response_i,FEB6_Response_i;

/*Host_Communication  Host_ROD_FEB_Communication_inst(
.clk_ila                    (clk_200M),
.reset                      (reset),
.sync_clk                   (clk_40M),
.external_trigger           (External_Trigger),
.ethernet_userclk           (ethernet_userclk),
.ethernet_corerdy           (ethernet_corerdy),
.ethernet_tx_data           (ethernet_tx_data),
.ethernet_tx_keep           (ethernet_tx_keep),
.ethernet_tx_valid          (ethernet_tx_valid),
.ethernet_tx_last           (ethernet_tx_last),
.ethernet_tx_ready          (ethernet_tx_ready),
.ethernet_rx_data           (ethernet_rx_data),
.ethernet_rx_keep           (ethernet_rx_keep),
.ethernet_rx_valid          (ethernet_rx_valid),
.ethernet_rx_last           (ethernet_rx_last),
.ethernet_rx_ready          (ethernet_rx_ready),
.ROD_command_FEB1           (ROD_command_FEB1),
.ROD_command_FEB2           (ROD_command_FEB2),
.ROD_command_FEB3           (ROD_command_FEB3),
.ROD_command_FEB4           (ROD_command_FEB4),
.ROD_command_FEB5           (ROD_command_FEB5),
.ROD_command_FEB6           (ROD_command_FEB6),
.Trigger_FEB1               (Trigger_FEB1_o),
.Trigger_FEB2               (Trigger_FEB2_o),
.Trigger_FEB3               (Trigger_FEB3_o),
.Trigger_FEB4               (Trigger_FEB4_o),
.Trigger_FEB5               (Trigger_FEB5_o),
.Trigger_FEB6               (Trigger_FEB6_o),
.FEB1_Response              (FEB1_Response_i),
.FEB2_Response              (FEB2_Response_i),
.FEB3_Response              (FEB3_Response_i),
.FEB4_Response              (FEB4_Response_i),
.FEB5_Response              (FEB5_Response_i),
.FEB6_Response              (FEB6_Response_i),
.FEB1_GTX_RX_data           (FEB1_GTX_RX_data),
.FEB1_GTX_RX_valid          (FEB1_GTX_RX_valid),
.FEB1_GTX_RX_CRC            (FEB1_GTX_RX_CRC),
.FEB1_GTX_RX_clk            (FEB1_GTX_RX_clk),
.FEB2_GTX_RX_data           (FEB2_GTX_RX_data),
.FEB2_GTX_RX_valid          (FEB2_GTX_RX_valid),
.FEB2_GTX_RX_CRC            (FEB2_GTX_RX_CRC),
.FEB2_GTX_RX_clk            (FEB2_GTX_RX_clk),
.FEB3_GTX_RX_data           (FEB3_GTX_RX_data),
.FEB3_GTX_RX_valid          (FEB3_GTX_RX_valid),
.FEB3_GTX_RX_CRC            (FEB3_GTX_RX_CRC),
.FEB3_GTX_RX_clk            (FEB3_GTX_RX_clk),
.FEB4_GTX_RX_data           (FEB4_GTX_RX_data),
.FEB4_GTX_RX_valid          (FEB4_GTX_RX_valid),
.FEB4_GTX_RX_CRC            (FEB4_GTX_RX_CRC),
.FEB4_GTX_RX_clk            (FEB4_GTX_RX_clk),
.FEB5_GTX_RX_data           (FEB5_GTX_RX_data),
.FEB5_GTX_RX_valid          (FEB5_GTX_RX_valid),
.FEB5_GTX_RX_CRC            (FEB5_GTX_RX_CRC),
.FEB5_GTX_RX_clk            (FEB5_GTX_RX_clk),
.FEB6_GTX_RX_data           (FEB6_GTX_RX_data),
.FEB6_GTX_RX_valid          (FEB6_GTX_RX_valid),
.FEB6_GTX_RX_CRC            (FEB6_GTX_RX_CRC),
.FEB6_GTX_RX_clk            (FEB6_GTX_RX_clk)
    );*/
    
OBUFDS OBUFDS_ROD_Command_FEB1 (
	.O(ROD_CMD_FEB1_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB1_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB1)      // Buffer input 
);    
    
OBUFDS OBUFDS_ROD_Command_FEB2 (
	.O(ROD_CMD_FEB2_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB2_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB2)      // Buffer input 
); 

OBUFDS OBUFDS_ROD_Command_FEB3 (
	.O(ROD_CMD_FEB3_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB3_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB3)      // Buffer input 
); 

OBUFDS OBUFDS_ROD_Command_FEB4 (
	.O(ROD_CMD_FEB4_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB4_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB4)      // Buffer input 
); 

OBUFDS OBUFDS_ROD_Command_FEB5 (
	.O(ROD_CMD_FEB5_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB5_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB5)      // Buffer input 
); 

OBUFDS OBUFDS_ROD_Command_FEB6 (
	.O(ROD_CMD_FEB6_p),     // Diff_p output (connect directly to top-level port)
	.OB(ROD_CMD_FEB6_n),   // Diff_n output (connect directly to top-level port)
	.I(ROD_command_FEB6)      // Buffer input 
);     
    
OBUFDS OBUFDS_Trigger_FEB1 (
	.O(Trigger_FEB1_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB1_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB1_o)      // Buffer input 
);

OBUFDS OBUFDS_Trigger_FEB2 (
	.O(Trigger_FEB2_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB2_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB2_o)      // Buffer input 
);

OBUFDS OBUFDS_Trigger_FEB3 (
	.O(Trigger_FEB3_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB3_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB3_o)      // Buffer input 
);

OBUFDS OBUFDS_Trigger_FEB4 (
	.O(Trigger_FEB4_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB4_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB4_o)      // Buffer input 
);

OBUFDS OBUFDS_Trigger_FEB5 (
	.O(Trigger_FEB5_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB5_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB5_o)      // Buffer input 
);

OBUFDS OBUFDS_Trigger_FEB6 (
	.O(Trigger_FEB6_p),     // Diff_p output (connect directly to top-level port)
	.OB(Trigger_FEB6_n),   // Diff_n output (connect directly to top-level port)
	.I(Trigger_FEB6_o)      // Buffer input 
);

IBUFDS  IBUFDS_FEB1_Response (
	.O(FEB1_Response_i),     // Buffer output
	.I(FEB1_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB1_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS  IBUFDS_FEB2_Response (
	.O(FEB2_Response_i),     // Buffer output
	.I(FEB2_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB2_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS  IBUFDS_FEB3_Response (
	.O(FEB3_Response_i),     // Buffer output
	.I(FEB3_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB3_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS  IBUFDS_FEB4_Response (
	.O(FEB4_Response_i),     // Buffer output
	.I(FEB4_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB4_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS  IBUFDS_FEB5_Response (
	.O(FEB5_Response_i),     // Buffer output
	.I(FEB5_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB5_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS  IBUFDS_FEB6_Response (
	.O(FEB6_Response_i),     // Buffer output
	.I(FEB6_Response_p),         // Diff_p buffer input (connect directly to top-level port)
	.IB(FEB6_Response_n)         // Diff_n buffer input (connect directly to top-level port)
);

    
endmodule

