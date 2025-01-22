`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/22 10:24:09
// Design Name: 
// Module Name: GTX_ROD_Datalink
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

`timescale 1ns / 1ps
`define DLY #1

(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
(* CORE_GENERATION_INFO = "GTX_ROD_Link,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}" *)
module GTX_ROD_Datalink #
(
    parameter EXAMPLE_CONFIG_INDEPENDENT_LANES     =   1,//configuration for frame gen and check
    parameter EXAMPLE_LANE_WITH_START_CHAR         =   0,         // specifies lane with unique start frame char
    parameter EXAMPLE_WORDS_IN_BRAM                =   512,       // specifies amount of data in BRAM
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP          =   "TRUE",    // simulation setting for GT SecureIP model
    parameter EXAMPLE_USE_CHIPSCOPE                =   0,         // Set to 1 to use Chipscope to drive resets
    parameter STABLE_CLOCK_PERIOD                  = 10

)
(
    input   wire        reset,
    input   wire        Q2_CLK0_GTREFCLK_PAD_N_IN,
    input   wire        Q2_CLK0_GTREFCLK_PAD_P_IN,
    input   wire        DRPCLK_IN,
    input   wire [5:0]  RXN_IN,
    input   wire [5:0]  RXP_IN,
    output  wire [5:0]  TXN_OUT,
    output  wire [5:0]  TXP_OUT,
    
    output  wire [31:0] FEB1_GTX_RX_data,
    output  wire        FEB1_GTX_RX_valid,
    output  wire        FEB1_GTX_RX_CRC,
    output  wire        FEB1_GTX_RX_clk,
    
    output  wire [31:0] FEB2_GTX_RX_data,
    output  wire        FEB2_GTX_RX_valid,
    output  wire        FEB2_GTX_RX_CRC,
    output  wire        FEB2_GTX_RX_clk,

    output  wire [31:0] FEB3_GTX_RX_data,
    output  wire        FEB3_GTX_RX_valid,
    output  wire        FEB3_GTX_RX_CRC,
    output  wire        FEB3_GTX_RX_clk,

    output  wire [31:0] FEB4_GTX_RX_data,
    output  wire        FEB4_GTX_RX_valid,
    output  wire        FEB4_GTX_RX_CRC,
    output  wire        FEB4_GTX_RX_clk,
    
    output  wire [31:0] FEB5_GTX_RX_data,
    output  wire        FEB5_GTX_RX_valid,
    output  wire        FEB5_GTX_RX_CRC,
    output  wire        FEB5_GTX_RX_clk,

    output  wire [31:0] FEB6_GTX_RX_data,
    output  wire        FEB6_GTX_RX_valid,
    output  wire        FEB6_GTX_RX_CRC,
    output  wire        FEB6_GTX_RX_clk

);

    wire soft_reset_i;
//    (*mark_debug = "TRUE" *) wire soft_reset_vio_i;

//************************** Register Declarations ****************************

    wire            gt_txfsmresetdone_i;
    wire            gt_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r2;
    wire            gt0_txfsmresetdone_i;
    wire            gt0_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r3;

    wire            gt1_txfsmresetdone_i;
    wire            gt1_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt1_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_vio_r3;

    wire            gt2_txfsmresetdone_i;
    wire            gt2_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt2_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt2_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt2_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt2_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt2_rxresetdone_vio_r3;

    wire            gt3_txfsmresetdone_i;
    wire            gt3_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt3_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt3_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt3_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt3_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt3_rxresetdone_vio_r3;

    wire            gt4_txfsmresetdone_i;
    wire            gt4_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt4_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt4_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt4_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt4_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt4_rxresetdone_vio_r3;

    wire            gt5_txfsmresetdone_i;
    wire            gt5_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt5_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt5_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt5_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt5_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_r3;
//    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_vio_r;
//    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_vio_r2;
//    (* ASYNC_REG = "TRUE" *)reg             gt5_rxresetdone_vio_r3;

    reg [5:0] reset_counter = 0;
    reg     [3:0]   reset_pulse;

//**************************** Wire Declarations ******************************//
    //------------------------ GT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GT0  (X1Y4)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt0_drpaddr_i;
    wire    [15:0]  gt0_drpdi_i;
    wire    [15:0]  gt0_drpdo_i;
    wire            gt0_drpen_i;
    wire            gt0_drprdy_i;
    wire            gt0_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt0_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt0_eyescanreset_i;
    wire            gt0_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt0_eyescandataerror_i;
    wire            gt0_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt0_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt0_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt0_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt0_rxdfelpmreset_i;
    wire    [6:0]   gt0_rxmonitorout_i;
    wire    [1:0]   gt0_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt0_rxoutclk_i;
    wire            gt0_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt0_gtrxreset_i;
    wire            gt0_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt0_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt0_gttxreset_i;
    wire            gt0_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt0_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt0_gtxtxn_i;
    wire            gt0_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt0_txoutclk_i;
    wire            gt0_txoutclkfabric_i;
    wire            gt0_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt0_txresetdone_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT1  (X1Y6)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt1_drpaddr_i;
    wire    [15:0]  gt1_drpdi_i;
    wire    [15:0]  gt1_drpdo_i;
    wire            gt1_drpen_i;
    wire            gt1_drprdy_i;
    wire            gt1_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt1_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt1_eyescanreset_i;
    wire            gt1_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt1_eyescandataerror_i;
    wire            gt1_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt1_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt1_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt1_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt1_rxdfelpmreset_i;
    wire    [6:0]   gt1_rxmonitorout_i;
    wire    [1:0]   gt1_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt1_rxoutclk_i;
    wire            gt1_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt1_gtrxreset_i;
    wire            gt1_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt1_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt1_gttxreset_i;
    wire            gt1_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt1_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt1_gtxtxn_i;
    wire            gt1_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt1_txoutclk_i;
    wire            gt1_txoutclkfabric_i;
    wire            gt1_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt1_txresetdone_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT2  (X1Y8)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt2_drpaddr_i;
    wire    [15:0]  gt2_drpdi_i;
    wire    [15:0]  gt2_drpdo_i;
    wire            gt2_drpen_i;
    wire            gt2_drprdy_i;
    wire            gt2_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt2_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt2_eyescanreset_i;
    wire            gt2_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt2_eyescandataerror_i;
    wire            gt2_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt2_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt2_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt2_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt2_rxdfelpmreset_i;
    wire    [6:0]   gt2_rxmonitorout_i;
    wire    [1:0]   gt2_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt2_rxoutclk_i;
    wire            gt2_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt2_gtrxreset_i;
    wire            gt2_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt2_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt2_gttxreset_i;
    wire            gt2_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt2_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt2_gtxtxn_i;
    wire            gt2_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt2_txoutclk_i;
    wire            gt2_txoutclkfabric_i;
    wire            gt2_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt2_txresetdone_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT3  (X1Y9)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt3_drpaddr_i;
    wire    [15:0]  gt3_drpdi_i;
    wire    [15:0]  gt3_drpdo_i;
    wire            gt3_drpen_i;
    wire            gt3_drprdy_i;
    wire            gt3_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt3_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt3_eyescanreset_i;
    wire            gt3_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt3_eyescandataerror_i;
    wire            gt3_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt3_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt3_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt3_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt3_rxdfelpmreset_i;
    wire    [6:0]   gt3_rxmonitorout_i;
    wire    [1:0]   gt3_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt3_rxoutclk_i;
    wire            gt3_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt3_gtrxreset_i;
    wire            gt3_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt3_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt3_gttxreset_i;
    wire            gt3_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt3_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt3_gtxtxn_i;
    wire            gt3_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt3_txoutclk_i;
    wire            gt3_txoutclkfabric_i;
    wire            gt3_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt3_txresetdone_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT4  (X1Y12)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt4_drpaddr_i;
    wire    [15:0]  gt4_drpdi_i;
    wire    [15:0]  gt4_drpdo_i;
    wire            gt4_drpen_i;
    wire            gt4_drprdy_i;
    wire            gt4_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt4_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt4_eyescanreset_i;
    wire            gt4_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt4_eyescandataerror_i;
    wire            gt4_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt4_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt4_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt4_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt4_rxdfelpmreset_i;
    wire    [6:0]   gt4_rxmonitorout_i;
    wire    [1:0]   gt4_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt4_rxoutclk_i;
    wire            gt4_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt4_gtrxreset_i;
    wire            gt4_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt4_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt4_gttxreset_i;
    wire            gt4_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt4_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt4_gtxtxn_i;
    wire            gt4_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt4_txoutclk_i;
    wire            gt4_txoutclkfabric_i;
    wire            gt4_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt4_txresetdone_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT5  (X1Y13)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt5_drpaddr_i;
    wire    [15:0]  gt5_drpdi_i;
    wire    [15:0]  gt5_drpdo_i;
    wire            gt5_drpen_i;
    wire            gt5_drprdy_i;
    wire            gt5_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt5_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt5_eyescanreset_i;
    wire            gt5_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt5_eyescandataerror_i;
    wire            gt5_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [39:0]  gt5_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt5_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt5_gtxrxn_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt5_rxdfelpmreset_i;
    wire    [6:0]   gt5_rxmonitorout_i;
    wire    [1:0]   gt5_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt5_rxoutclk_i;
    wire            gt5_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt5_gtrxreset_i;
    wire            gt5_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt5_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt5_gttxreset_i;
    wire            gt5_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [39:0]  gt5_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt5_gtxtxn_i;
    wire            gt5_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt5_txoutclk_i;
    wire            gt5_txoutclkfabric_i;
    wire            gt5_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt5_txresetdone_i;

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt0_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt0_qplllock_i;
    wire            gt0_qpllrefclklost_i;
    wire            gt0_qpllreset_i;

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt1_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt1_qplllock_i;
    wire            gt1_qpllrefclklost_i;
    wire            gt1_qpllreset_i;

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt2_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt2_qplllock_i;
    wire            gt2_qpllrefclklost_i;
    wire            gt2_qpllreset_i;


    //----------------------------- Global Signals -----------------------------

    wire            drpclk_in_i;
//    wire            DRPCLK_IN;
    wire            gt0_tx_system_reset_c;
    wire            gt0_rx_system_reset_c;
    wire            gt1_tx_system_reset_c;
    wire            gt1_rx_system_reset_c;
    wire            gt2_tx_system_reset_c;
    wire            gt2_rx_system_reset_c;
    wire            gt3_tx_system_reset_c;
    wire            gt3_rx_system_reset_c;
    wire            gt4_tx_system_reset_c;
    wire            gt4_rx_system_reset_c;
    wire            gt5_tx_system_reset_c;
    wire            gt5_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            GTTXRESET_IN;
    wire            GTRXRESET_IN;
    wire            QPLLRESET_IN;

     //--------------------------- User Clocks ---------------------------------
     wire            gt0_txusrclk_i; 
     wire            gt0_txusrclk2_i; 
     wire            gt0_rxusrclk_i; 
     wire            gt0_rxusrclk2_i; 
     wire            gt1_txusrclk_i; 
     wire            gt1_txusrclk2_i; 
     wire            gt1_rxusrclk_i; 
     wire            gt1_rxusrclk2_i; 
     wire            gt2_txusrclk_i; 
     wire            gt2_txusrclk2_i; 
     wire            gt2_rxusrclk_i; 
     wire            gt2_rxusrclk2_i; 
     wire            gt3_txusrclk_i; 
     wire            gt3_txusrclk2_i; 
     wire            gt3_rxusrclk_i; 
     wire            gt3_rxusrclk2_i; 
     wire            gt4_txusrclk_i; 
     wire            gt4_txusrclk2_i; 
     wire            gt4_rxusrclk_i; 
     wire            gt4_rxusrclk2_i; 
     wire            gt5_txusrclk_i; 
     wire            gt5_txusrclk2_i; 
     wire            gt5_rxusrclk_i; 
     wire            gt5_rxusrclk2_i; 
 
    //--------------------------- Reference Clocks ----------------------------
    
    wire            q2_clk0_refclk_i;


    //--------------------- Frame check/gen Module Signals --------------------
    wire            gt0_matchn_i;
    
    wire    [2:0]   gt0_txcharisk_float_i;
   
    wire    [15:0]  gt0_txdata_float16_i;
    wire    [23:0]  gt0_txdata_float_i;
    
    
    wire            gt0_block_sync_i;
    wire            gt0_track_data_i;
    wire    [7:0]   gt0_error_count_i;
    wire            gt0_frame_check_reset_i;
    wire            gt0_inc_in_i;
    wire            gt0_inc_out_i;
    wire    [39:0]  gt0_unscrambled_data_i;

    wire            gt1_matchn_i;
    
    wire    [2:0]   gt1_txcharisk_float_i;
   
    wire    [15:0]  gt1_txdata_float16_i;
    wire    [23:0]  gt1_txdata_float_i;
    
    
    wire            gt1_block_sync_i;
    wire            gt1_track_data_i;
    wire    [7:0]   gt1_error_count_i;
    wire            gt1_frame_check_reset_i;
    wire            gt1_inc_in_i;
    wire            gt1_inc_out_i;
    wire    [39:0]  gt1_unscrambled_data_i;

    wire            gt2_matchn_i;
    
    wire    [2:0]   gt2_txcharisk_float_i;
   
    wire    [15:0]  gt2_txdata_float16_i;
    wire    [23:0]  gt2_txdata_float_i;
    
    
    wire            gt2_block_sync_i;
    wire            gt2_track_data_i;
    wire    [7:0]   gt2_error_count_i;
    wire            gt2_frame_check_reset_i;
    wire            gt2_inc_in_i;
    wire            gt2_inc_out_i;
    wire    [39:0]  gt2_unscrambled_data_i;

    wire            gt3_matchn_i;
    
    wire    [2:0]   gt3_txcharisk_float_i;
   
    wire    [15:0]  gt3_txdata_float16_i;
    wire    [23:0]  gt3_txdata_float_i;
    
    
    wire            gt3_block_sync_i;
    wire            gt3_track_data_i;
    wire    [7:0]   gt3_error_count_i;
    wire            gt3_frame_check_reset_i;
    wire            gt3_inc_in_i;
    wire            gt3_inc_out_i;
    wire    [39:0]  gt3_unscrambled_data_i;

    wire            gt4_matchn_i;
    
    wire    [2:0]   gt4_txcharisk_float_i;
   
    wire    [15:0]  gt4_txdata_float16_i;
    wire    [23:0]  gt4_txdata_float_i;
    
    
    wire            gt4_block_sync_i;
    wire            gt4_track_data_i;
    wire    [7:0]   gt4_error_count_i;
    wire            gt4_frame_check_reset_i;
    wire            gt4_inc_in_i;
    wire            gt4_inc_out_i;
    wire    [39:0]  gt4_unscrambled_data_i;

    wire            gt5_matchn_i;
    
    wire    [2:0]   gt5_txcharisk_float_i;
   
    wire    [15:0]  gt5_txdata_float16_i;
    wire    [23:0]  gt5_txdata_float_i;
    
    
    wire            gt5_block_sync_i;
    wire            gt5_track_data_i;
    wire    [7:0]   gt5_error_count_i;
    wire            gt5_frame_check_reset_i;
    wire            gt5_inc_in_i;
    wire            gt5_inc_out_i;
    wire    [39:0]  gt5_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;
  

    //--------------------- Chipscope Signals ---------------------------------
//    (*mark_debug = "TRUE" *)wire   rxresetdone_vio_i;
//    wire    [35:0]  tx_data_vio_control_i;
//    wire    [35:0]  rx_data_vio_control_i;
//    wire    [35:0]  shared_vio_control_i;
//    wire    [35:0]  ila_control_i;
//    wire    [35:0]  channel_drp_vio_control_i;
//    wire    [35:0]  common_drp_vio_control_i;
//    wire    [31:0]  tx_data_vio_async_in_i;
//    wire    [31:0]  tx_data_vio_sync_in_i;
//    wire    [31:0]  tx_data_vio_async_out_i;
//    wire    [31:0]  tx_data_vio_sync_out_i;
//    wire    [31:0]  rx_data_vio_async_in_i;
//    wire    [31:0]  rx_data_vio_sync_in_i;
//    wire    [31:0]  rx_data_vio_async_out_i;
//    wire    [31:0]  rx_data_vio_sync_out_i;
//    wire    [31:0]  shared_vio_in_i;
//    wire    [31:0]  shared_vio_out_i;
//    wire    [163:0] ila_in_i;
//    wire    [31:0]  channel_drp_vio_async_in_i;
//    wire    [31:0]  channel_drp_vio_sync_in_i;
//    wire    [31:0]  channel_drp_vio_async_out_i;
//    wire    [31:0]  channel_drp_vio_sync_out_i;
//    wire    [31:0]  common_drp_vio_async_in_i;
//    wire    [31:0]  common_drp_vio_sync_in_i;
//    wire    [31:0]  common_drp_vio_async_out_i;
//    wire    [31:0]  common_drp_vio_sync_out_i;

//    wire    [31:0]  gt0_tx_data_vio_async_in_i;
//    wire    [31:0]  gt0_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt0_tx_data_vio_async_out_i;
//    wire    [31:0]  gt0_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt0_rx_data_vio_async_in_i;
//    wire    [31:0]  gt0_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt0_rx_data_vio_async_out_i;
//    wire    [31:0]  gt0_rx_data_vio_sync_out_i;
//    wire    [163:0] gt0_ila_in_i;
//    wire    [31:0]  gt0_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt0_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt0_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt0_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt0_common_drp_vio_async_in_i;
//    wire    [31:0]  gt0_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt0_common_drp_vio_async_out_i;
//    wire    [31:0]  gt0_common_drp_vio_sync_out_i;

//    wire    [31:0]  gt1_tx_data_vio_async_in_i;
//    wire    [31:0]  gt1_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt1_tx_data_vio_async_out_i;
//    wire    [31:0]  gt1_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt1_rx_data_vio_async_in_i;
//    wire    [31:0]  gt1_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt1_rx_data_vio_async_out_i;
//    wire    [31:0]  gt1_rx_data_vio_sync_out_i;
//    wire    [163:0] gt1_ila_in_i;
//    wire    [31:0]  gt1_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt1_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt1_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt1_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt1_common_drp_vio_async_in_i;
//    wire    [31:0]  gt1_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt1_common_drp_vio_async_out_i;
//    wire    [31:0]  gt1_common_drp_vio_sync_out_i;

//    wire    [31:0]  gt2_tx_data_vio_async_in_i;
//    wire    [31:0]  gt2_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt2_tx_data_vio_async_out_i;
//    wire    [31:0]  gt2_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt2_rx_data_vio_async_in_i;
//    wire    [31:0]  gt2_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt2_rx_data_vio_async_out_i;
//    wire    [31:0]  gt2_rx_data_vio_sync_out_i;
//    wire    [163:0] gt2_ila_in_i;
//    wire    [31:0]  gt2_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt2_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt2_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt2_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt2_common_drp_vio_async_in_i;
//    wire    [31:0]  gt2_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt2_common_drp_vio_async_out_i;
//    wire    [31:0]  gt2_common_drp_vio_sync_out_i;

//    wire    [31:0]  gt3_tx_data_vio_async_in_i;
//    wire    [31:0]  gt3_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt3_tx_data_vio_async_out_i;
//    wire    [31:0]  gt3_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt3_rx_data_vio_async_in_i;
//    wire    [31:0]  gt3_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt3_rx_data_vio_async_out_i;
//    wire    [31:0]  gt3_rx_data_vio_sync_out_i;
//    wire    [163:0] gt3_ila_in_i;
//    wire    [31:0]  gt3_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt3_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt3_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt3_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt3_common_drp_vio_async_in_i;
//    wire    [31:0]  gt3_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt3_common_drp_vio_async_out_i;
//    wire    [31:0]  gt3_common_drp_vio_sync_out_i;

//    wire    [31:0]  gt4_tx_data_vio_async_in_i;
//    wire    [31:0]  gt4_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt4_tx_data_vio_async_out_i;
//    wire    [31:0]  gt4_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt4_rx_data_vio_async_in_i;
//    wire    [31:0]  gt4_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt4_rx_data_vio_async_out_i;
//    wire    [31:0]  gt4_rx_data_vio_sync_out_i;
//    wire    [163:0] gt4_ila_in_i;
//    wire    [31:0]  gt4_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt4_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt4_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt4_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt4_common_drp_vio_async_in_i;
//    wire    [31:0]  gt4_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt4_common_drp_vio_async_out_i;
//    wire    [31:0]  gt4_common_drp_vio_sync_out_i;

//    wire    [31:0]  gt5_tx_data_vio_async_in_i;
//    wire    [31:0]  gt5_tx_data_vio_sync_in_i;
//    wire    [31:0]  gt5_tx_data_vio_async_out_i;
//    wire    [31:0]  gt5_tx_data_vio_sync_out_i;
//    wire    [31:0]  gt5_rx_data_vio_async_in_i;
//    wire    [31:0]  gt5_rx_data_vio_sync_in_i;
//    wire    [31:0]  gt5_rx_data_vio_async_out_i;
//    wire    [31:0]  gt5_rx_data_vio_sync_out_i;
//    wire    [163:0] gt5_ila_in_i;
//    wire    [31:0]  gt5_channel_drp_vio_async_in_i;
//    wire    [31:0]  gt5_channel_drp_vio_sync_in_i;
//    wire    [31:0]  gt5_channel_drp_vio_async_out_i;
//    wire    [31:0]  gt5_channel_drp_vio_sync_out_i;
//    wire    [31:0]  gt5_common_drp_vio_async_in_i;
//    wire    [31:0]  gt5_common_drp_vio_sync_in_i;
//    wire    [31:0]  gt5_common_drp_vio_async_out_i;
//    wire    [31:0]  gt5_common_drp_vio_sync_out_i;


//    wire            gttxreset_i;
//    wire            gtrxreset_i;
//    wire    [2:0]   mux_sel_i;

//    wire            user_tx_reset_i;
//    wire            user_rx_reset_i;
//    wire            tx_vio_clk_i;
//    wire            tx_vio_clk_mux_out_i;    
//    wire            rx_vio_ila_clk_i;
//    wire            rx_vio_ila_clk_mux_out_i;

//    wire            qpllreset_i;
    


//  wire [(80 -40) -1:0] zero_vector_rx_80 ;
//  wire [(8 -5) -1:0] zero_vector_rx_8 ;
//  wire [79:0] gt0_rxdata_ila ;
//  wire [1:0]  gt0_rxdatavalid_ila; 
//  wire [7:0]  gt0_rxcharisk_ila ;
//  wire gt0_txmmcm_lock_ila ;
//  wire gt0_rxmmcm_lock_ila ;
//  wire gt0_rxresetdone_ila ;
//  wire gt0_txresetdone_ila ;
//  wire [79:0] gt1_rxdata_ila ;
//  wire [1:0]  gt1_rxdatavalid_ila; 
//  wire [7:0]  gt1_rxcharisk_ila ;
//  wire gt1_txmmcm_lock_ila ;
//  wire gt1_rxmmcm_lock_ila ;
//  wire gt1_rxresetdone_ila ;
//  wire gt1_txresetdone_ila ;
//  wire [79:0] gt2_rxdata_ila ;
//  wire [1:0]  gt2_rxdatavalid_ila; 
//  wire [7:0]  gt2_rxcharisk_ila ;
//  wire gt2_txmmcm_lock_ila ;
//  wire gt2_rxmmcm_lock_ila ;
//  wire gt2_rxresetdone_ila ;
//  wire gt2_txresetdone_ila ;
//  wire [79:0] gt3_rxdata_ila ;
//  wire [1:0]  gt3_rxdatavalid_ila; 
//  wire [7:0]  gt3_rxcharisk_ila ;
//  wire gt3_txmmcm_lock_ila ;
//  wire gt3_rxmmcm_lock_ila ;
//  wire gt3_rxresetdone_ila ;
//  wire gt3_txresetdone_ila ;
//  wire [79:0] gt4_rxdata_ila ;
//  wire [1:0]  gt4_rxdatavalid_ila; 
//  wire [7:0]  gt4_rxcharisk_ila ;
//  wire gt4_txmmcm_lock_ila ;
//  wire gt4_rxmmcm_lock_ila ;
//  wire gt4_rxresetdone_ila ;
//  wire gt4_txresetdone_ila ;
//  wire [79:0] gt5_rxdata_ila ;
//  wire [1:0]  gt5_rxdatavalid_ila; 
//  wire [7:0]  gt5_rxcharisk_ila ;
//  wire gt5_txmmcm_lock_ila ;
//  wire gt5_rxmmcm_lock_ila ;
//  wire gt5_rxresetdone_ila ;
//  wire gt5_txresetdone_ila ;

//**************************** Main Body of Code *******************************

    //  Static signal Assigments    
    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 8'hff;

//    assign zero_vector_rx_80 = 0;
//    assign zero_vector_rx_8 = 0;

    
assign  q2_clk0_refclk_i                     =  1'b0;

    //***********************************************************************//
    //                                                                       //
    //--------------------------- The GT Wrapper ----------------------------//
    //                                                                       //
    //***********************************************************************//
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.
    // While connecting the GT TX/RX Reset ports below, please add a delay of
    // minimum 500ns as mentioned in AR 43482.

    
    GTX_ROD_Link_support #
    (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP),
        .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD)
    )
    GTX_ROD_Link_support_i
    (
        .soft_reset_tx_in               (soft_reset_i | reset),
        .soft_reset_rx_in               (soft_reset_i | reset),
        .dont_reset_on_data_error_in    (tied_to_ground_i),
        .q2_clk0_gtrefclk_pad_n_in      (Q2_CLK0_GTREFCLK_PAD_N_IN),
        .q2_clk0_gtrefclk_pad_p_in      (Q2_CLK0_GTREFCLK_PAD_P_IN),
        .gt0_tx_fsm_reset_done_out      (gt0_txfsmresetdone_i),
        .gt0_rx_fsm_reset_done_out      (gt0_rxfsmresetdone_i),
        .gt0_data_valid_in              (gt0_track_data_i),
        .gt1_tx_fsm_reset_done_out      (gt1_txfsmresetdone_i),
        .gt1_rx_fsm_reset_done_out      (gt1_rxfsmresetdone_i),
        .gt1_data_valid_in              (gt1_track_data_i),
        .gt2_tx_fsm_reset_done_out      (gt2_txfsmresetdone_i),
        .gt2_rx_fsm_reset_done_out      (gt2_rxfsmresetdone_i),
        .gt2_data_valid_in              (gt2_track_data_i),
        .gt3_tx_fsm_reset_done_out      (gt3_txfsmresetdone_i),
        .gt3_rx_fsm_reset_done_out      (gt3_rxfsmresetdone_i),
        .gt3_data_valid_in              (gt3_track_data_i),
        .gt4_tx_fsm_reset_done_out      (gt4_txfsmresetdone_i),
        .gt4_rx_fsm_reset_done_out      (gt4_rxfsmresetdone_i),
        .gt4_data_valid_in              (gt4_track_data_i),
        .gt5_tx_fsm_reset_done_out      (gt5_txfsmresetdone_i),
        .gt5_rx_fsm_reset_done_out      (gt5_rxfsmresetdone_i),
        .gt5_data_valid_in              (gt5_track_data_i),
 
    .gt0_txusrclk_out(gt0_txusrclk_i),
    .gt0_txusrclk2_out(gt0_txusrclk2_i),
    .gt0_rxusrclk_out(gt0_rxusrclk_i),
    .gt0_rxusrclk2_out(gt0_rxusrclk2_i),
 
    .gt1_txusrclk_out(gt1_txusrclk_i),
    .gt1_txusrclk2_out(gt1_txusrclk2_i),
    .gt1_rxusrclk_out(gt1_rxusrclk_i),
    .gt1_rxusrclk2_out(gt1_rxusrclk2_i),
 
    .gt2_txusrclk_out(gt2_txusrclk_i),
    .gt2_txusrclk2_out(gt2_txusrclk2_i),
    .gt2_rxusrclk_out(gt2_rxusrclk_i),
    .gt2_rxusrclk2_out(gt2_rxusrclk2_i),
 
    .gt3_txusrclk_out(gt3_txusrclk_i),
    .gt3_txusrclk2_out(gt3_txusrclk2_i),
    .gt3_rxusrclk_out(gt3_rxusrclk_i),
    .gt3_rxusrclk2_out(gt3_rxusrclk2_i),
 
    .gt4_txusrclk_out(gt4_txusrclk_i),
    .gt4_txusrclk2_out(gt4_txusrclk2_i),
    .gt4_rxusrclk_out(gt4_rxusrclk_i),
    .gt4_rxusrclk2_out(gt4_rxusrclk2_i),
 
    .gt5_txusrclk_out(gt5_txusrclk_i),
    .gt5_txusrclk2_out(gt5_txusrclk2_i),
    .gt5_rxusrclk_out(gt5_rxusrclk_i),
    .gt5_rxusrclk2_out(gt5_rxusrclk2_i),


        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X1Y4)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_i),
        .gt0_drpdi_in                   (gt0_drpdi_i),
        .gt0_drpdo_out                  (gt0_drpdo_i),
        .gt0_drpen_in                   (gt0_drpen_i),
        .gt0_drprdy_out                 (gt0_drprdy_i),
        .gt0_drpwe_in                   (gt0_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (tied_to_ground_i),
        .gt0_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_i),
        .gt0_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 (gt0_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt0_gtxrxp_in                  (RXP_IN[0]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gtxrxn_in                  (RXN_IN[0]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxdfelpmreset_in           (tied_to_ground_i),
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_i),
        .gt0_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (tied_to_ground_i),
        .gt0_rxpmareset_in              (gt0_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt0_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (tied_to_ground_i),
        .gt0_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt0_txdata_in                  (gt0_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt0_gtxtxn_out                 (TXN_OUT[0]),
        .gt0_gtxtxp_out                 (TXP_OUT[0]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i),
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txresetdone_out            (gt0_txresetdone_i),



        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT1  (X1Y6)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt1_drpaddr_in                 (gt1_drpaddr_i),
        .gt1_drpdi_in                   (gt1_drpdi_i),
        .gt1_drpdo_out                  (gt1_drpdo_i),
        .gt1_drpen_in                   (gt1_drpen_i),
        .gt1_drprdy_out                 (gt1_drprdy_i),
        .gt1_drpwe_in                   (gt1_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt1_dmonitorout_out            (gt1_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt1_eyescanreset_in            (tied_to_ground_i),
        .gt1_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt1_eyescandataerror_out       (gt1_eyescandataerror_i),
        .gt1_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt1_rxdata_out                 (gt1_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt1_gtxrxp_in                  (RXP_IN[1]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt1_gtxrxn_in                  (RXN_IN[1]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt1_rxdfelpmreset_in           (tied_to_ground_i),
        .gt1_rxmonitorout_out           (gt1_rxmonitorout_i),
        .gt1_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt1_rxoutclkfabric_out         (gt1_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt1_gtrxreset_in               (tied_to_ground_i),
        .gt1_rxpmareset_in              (gt1_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt1_rxresetdone_out            (gt1_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt1_gttxreset_in               (tied_to_ground_i),
        .gt1_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt1_txdata_in                  (gt1_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt1_gtxtxn_out                 (TXN_OUT[1]),
        .gt1_gtxtxp_out                 (TXP_OUT[1]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt1_txoutclkfabric_out         (gt1_txoutclkfabric_i),
        .gt1_txoutclkpcs_out            (gt1_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt1_txresetdone_out            (gt1_txresetdone_i),



        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT2  (X1Y8)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt2_drpaddr_in                 (gt2_drpaddr_i),
        .gt2_drpdi_in                   (gt2_drpdi_i),
        .gt2_drpdo_out                  (gt2_drpdo_i),
        .gt2_drpen_in                   (gt2_drpen_i),
        .gt2_drprdy_out                 (gt2_drprdy_i),
        .gt2_drpwe_in                   (gt2_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt2_dmonitorout_out            (gt2_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt2_eyescanreset_in            (tied_to_ground_i),
        .gt2_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt2_eyescandataerror_out       (gt2_eyescandataerror_i),
        .gt2_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt2_rxdata_out                 (gt2_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt2_gtxrxp_in                  (RXP_IN[2]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt2_gtxrxn_in                  (RXN_IN[2]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt2_rxdfelpmreset_in           (tied_to_ground_i),
        .gt2_rxmonitorout_out           (gt2_rxmonitorout_i),
        .gt2_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt2_rxoutclkfabric_out         (gt2_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt2_gtrxreset_in               (tied_to_ground_i),
        .gt2_rxpmareset_in              (gt2_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt2_rxresetdone_out            (gt2_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt2_gttxreset_in               (tied_to_ground_i),
        .gt2_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt2_txdata_in                  (gt2_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt2_gtxtxn_out                 (TXN_OUT[2]),
        .gt2_gtxtxp_out                 (TXP_OUT[2]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt2_txoutclkfabric_out         (gt2_txoutclkfabric_i),
        .gt2_txoutclkpcs_out            (gt2_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt2_txresetdone_out            (gt2_txresetdone_i),



        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT3  (X1Y9)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt3_drpaddr_in                 (gt3_drpaddr_i),
        .gt3_drpdi_in                   (gt3_drpdi_i),
        .gt3_drpdo_out                  (gt3_drpdo_i),
        .gt3_drpen_in                   (gt3_drpen_i),
        .gt3_drprdy_out                 (gt3_drprdy_i),
        .gt3_drpwe_in                   (gt3_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt3_dmonitorout_out            (gt3_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt3_eyescanreset_in            (tied_to_ground_i),
        .gt3_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt3_eyescandataerror_out       (gt3_eyescandataerror_i),
        .gt3_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt3_rxdata_out                 (gt3_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt3_gtxrxp_in                  (RXP_IN[3]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt3_gtxrxn_in                  (RXN_IN[3]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt3_rxdfelpmreset_in           (tied_to_ground_i),
        .gt3_rxmonitorout_out           (gt3_rxmonitorout_i),
        .gt3_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt3_rxoutclkfabric_out         (gt3_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt3_gtrxreset_in               (tied_to_ground_i),
        .gt3_rxpmareset_in              (gt3_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt3_rxresetdone_out            (gt3_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt3_gttxreset_in               (tied_to_ground_i),
        .gt3_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt3_txdata_in                  (gt3_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt3_gtxtxn_out                 (TXN_OUT[3]),
        .gt3_gtxtxp_out                 (TXP_OUT[3]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt3_txoutclkfabric_out         (gt3_txoutclkfabric_i),
        .gt3_txoutclkpcs_out            (gt3_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt3_txresetdone_out            (gt3_txresetdone_i),



        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT4  (X1Y12)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt4_drpaddr_in                 (gt4_drpaddr_i),
        .gt4_drpdi_in                   (gt4_drpdi_i),
        .gt4_drpdo_out                  (gt4_drpdo_i),
        .gt4_drpen_in                   (gt4_drpen_i),
        .gt4_drprdy_out                 (gt4_drprdy_i),
        .gt4_drpwe_in                   (gt4_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt4_dmonitorout_out            (gt4_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt4_eyescanreset_in            (tied_to_ground_i),
        .gt4_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt4_eyescandataerror_out       (gt4_eyescandataerror_i),
        .gt4_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt4_rxdata_out                 (gt4_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt4_gtxrxp_in                  (RXP_IN[4]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt4_gtxrxn_in                  (RXN_IN[4]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt4_rxdfelpmreset_in           (tied_to_ground_i),
        .gt4_rxmonitorout_out           (gt4_rxmonitorout_i),
        .gt4_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt4_rxoutclkfabric_out         (gt4_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt4_gtrxreset_in               (tied_to_ground_i),
        .gt4_rxpmareset_in              (gt4_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt4_rxresetdone_out            (gt4_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt4_gttxreset_in               (tied_to_ground_i),
        .gt4_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt4_txdata_in                  (gt4_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt4_gtxtxn_out                 (TXN_OUT[4]),
        .gt4_gtxtxp_out                 (TXP_OUT[4]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt4_txoutclkfabric_out         (gt4_txoutclkfabric_i),
        .gt4_txoutclkpcs_out            (gt4_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt4_txresetdone_out            (gt4_txresetdone_i),



        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT5  (X1Y13)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt5_drpaddr_in                 (gt5_drpaddr_i),
        .gt5_drpdi_in                   (gt5_drpdi_i),
        .gt5_drpdo_out                  (gt5_drpdo_i),
        .gt5_drpen_in                   (gt5_drpen_i),
        .gt5_drprdy_out                 (gt5_drprdy_i),
        .gt5_drpwe_in                   (gt5_drpwe_i),
        //------------------------- Digital Monitor Ports --------------------------
        .gt5_dmonitorout_out            (gt5_dmonitorout_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt5_eyescanreset_in            (tied_to_ground_i),
        .gt5_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt5_eyescandataerror_out       (gt5_eyescandataerror_i),
        .gt5_eyescantrigger_in          (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt5_rxdata_out                 (gt5_rxdata_i),
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt5_gtxrxp_in                  (RXP_IN[5]),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt5_gtxrxn_in                  (RXN_IN[5]),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt5_rxdfelpmreset_in           (tied_to_ground_i),
        .gt5_rxmonitorout_out           (gt5_rxmonitorout_i),
        .gt5_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt5_rxoutclkfabric_out         (gt5_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt5_gtrxreset_in               (tied_to_ground_i),
        .gt5_rxpmareset_in              (gt5_rxpmareset_i),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt5_rxresetdone_out            (gt5_rxresetdone_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt5_gttxreset_in               (tied_to_ground_i),
        .gt5_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt5_txdata_in                  (gt5_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt5_gtxtxn_out                 (TXN_OUT[5]),
        .gt5_gtxtxp_out                 (TXP_OUT[5]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt5_txoutclkfabric_out         (gt5_txoutclkfabric_i),
        .gt5_txoutclkpcs_out            (gt5_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt5_txresetdone_out            (gt5_txresetdone_i),


    //____________________________COMMON PORTS________________________________
    .gt0_qplllock_out(),
    .gt0_qpllrefclklost_out(),
    .gt0_qplloutclk_out(),
    .gt0_qplloutrefclk_out(),
    .gt1_qplllock_out(),
    .gt1_qpllrefclklost_out(),
    .gt1_qplloutclk_out(),
    .gt1_qplloutrefclk_out(),
    .gt2_qplllock_out(),
    .gt2_qpllrefclklost_out(),
    .gt2_qplloutclk_out(),
    .gt2_qplloutrefclk_out(),
    .sysclk_in(drpclk_in_i)
    );

//    IBUFDS IBUFDS_DRP_CLK
//     (
//        .I  (DRP_CLK_IN_P),
//        .IB (DRP_CLK_IN_N),
//        .O  (DRPCLK_IN)
//     );

    BUFG DRP_CLK_BUFG
    (
        .I                              (DRPCLK_IN),
        .O                              (drpclk_in_i) 
    );

 
    //***********************************************************************//
    //                                                                       //
    //--------------------------- User Module Resets-------------------------//
    //                                                                       //
    //***********************************************************************//
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high. 
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected 
    // to the reset of the modules
    
always @(posedge gt0_rxusrclk2_i or negedge gt0_rxresetdone_i)

    begin
        if (!gt0_rxresetdone_i)
        begin
            gt0_rxresetdone_r    <=   `DLY 1'b0;
            gt0_rxresetdone_r2   <=   `DLY 1'b0;
            gt0_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_rxresetdone_r    <=   `DLY gt0_rxresetdone_i;
            gt0_rxresetdone_r2   <=   `DLY gt0_rxresetdone_r;
            gt0_rxresetdone_r3   <=   `DLY gt0_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt0_txusrclk2_i or negedge gt0_txfsmresetdone_i)

    begin
        if (!gt0_txfsmresetdone_i)
        begin
            gt0_txfsmresetdone_r    <=   `DLY 1'b0;
            gt0_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_txfsmresetdone_r    <=   `DLY gt0_txfsmresetdone_i;
            gt0_txfsmresetdone_r2   <=   `DLY gt0_txfsmresetdone_r;
        end
    end

always @(posedge gt1_rxusrclk2_i or negedge gt1_rxresetdone_i)

    begin
        if (!gt1_rxresetdone_i)
        begin
            gt1_rxresetdone_r    <=   `DLY 1'b0;
            gt1_rxresetdone_r2   <=   `DLY 1'b0;
            gt1_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt1_rxresetdone_r    <=   `DLY gt1_rxresetdone_i;
            gt1_rxresetdone_r2   <=   `DLY gt1_rxresetdone_r;
            gt1_rxresetdone_r3   <=   `DLY gt1_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt1_txusrclk2_i or negedge gt1_txfsmresetdone_i)

    begin
        if (!gt1_txfsmresetdone_i)
        begin
            gt1_txfsmresetdone_r    <=   `DLY 1'b0;
            gt1_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt1_txfsmresetdone_r    <=   `DLY gt1_txfsmresetdone_i;
            gt1_txfsmresetdone_r2   <=   `DLY gt1_txfsmresetdone_r;
        end
    end

always @(posedge gt2_rxusrclk2_i or negedge gt2_rxresetdone_i)

    begin
        if (!gt2_rxresetdone_i)
        begin
            gt2_rxresetdone_r    <=   `DLY 1'b0;
            gt2_rxresetdone_r2   <=   `DLY 1'b0;
            gt2_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt2_rxresetdone_r    <=   `DLY gt2_rxresetdone_i;
            gt2_rxresetdone_r2   <=   `DLY gt2_rxresetdone_r;
            gt2_rxresetdone_r3   <=   `DLY gt2_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt2_txusrclk2_i or negedge gt2_txfsmresetdone_i)

    begin
        if (!gt2_txfsmresetdone_i)
        begin
            gt2_txfsmresetdone_r    <=   `DLY 1'b0;
            gt2_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt2_txfsmresetdone_r    <=   `DLY gt2_txfsmresetdone_i;
            gt2_txfsmresetdone_r2   <=   `DLY gt2_txfsmresetdone_r;
        end
    end

always @(posedge gt3_rxusrclk2_i or negedge gt3_rxresetdone_i)

    begin
        if (!gt3_rxresetdone_i)
        begin
            gt3_rxresetdone_r    <=   `DLY 1'b0;
            gt3_rxresetdone_r2   <=   `DLY 1'b0;
            gt3_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt3_rxresetdone_r    <=   `DLY gt3_rxresetdone_i;
            gt3_rxresetdone_r2   <=   `DLY gt3_rxresetdone_r;
            gt3_rxresetdone_r3   <=   `DLY gt3_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt3_txusrclk2_i or negedge gt3_txfsmresetdone_i)

    begin
        if (!gt3_txfsmresetdone_i)
        begin
            gt3_txfsmresetdone_r    <=   `DLY 1'b0;
            gt3_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt3_txfsmresetdone_r    <=   `DLY gt3_txfsmresetdone_i;
            gt3_txfsmresetdone_r2   <=   `DLY gt3_txfsmresetdone_r;
        end
    end

always @(posedge gt4_rxusrclk2_i or negedge gt4_rxresetdone_i)

    begin
        if (!gt4_rxresetdone_i)
        begin
            gt4_rxresetdone_r    <=   `DLY 1'b0;
            gt4_rxresetdone_r2   <=   `DLY 1'b0;
            gt4_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt4_rxresetdone_r    <=   `DLY gt4_rxresetdone_i;
            gt4_rxresetdone_r2   <=   `DLY gt4_rxresetdone_r;
            gt4_rxresetdone_r3   <=   `DLY gt4_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt4_txusrclk2_i or negedge gt4_txfsmresetdone_i)

    begin
        if (!gt4_txfsmresetdone_i)
        begin
            gt4_txfsmresetdone_r    <=   `DLY 1'b0;
            gt4_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt4_txfsmresetdone_r    <=   `DLY gt4_txfsmresetdone_i;
            gt4_txfsmresetdone_r2   <=   `DLY gt4_txfsmresetdone_r;
        end
    end

always @(posedge gt5_rxusrclk2_i or negedge gt5_rxresetdone_i)

    begin
        if (!gt5_rxresetdone_i)
        begin
            gt5_rxresetdone_r    <=   `DLY 1'b0;
            gt5_rxresetdone_r2   <=   `DLY 1'b0;
            gt5_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt5_rxresetdone_r    <=   `DLY gt5_rxresetdone_i;
            gt5_rxresetdone_r2   <=   `DLY gt5_rxresetdone_r;
            gt5_rxresetdone_r3   <=   `DLY gt5_rxresetdone_r2;
        end
    end

    
    
always @(posedge  gt5_txusrclk2_i or negedge gt5_txfsmresetdone_i)

    begin
        if (!gt5_txfsmresetdone_i)
        begin
            gt5_txfsmresetdone_r    <=   `DLY 1'b0;
            gt5_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt5_txfsmresetdone_r    <=   `DLY gt5_txfsmresetdone_i;
            gt5_txfsmresetdone_r2   <=   `DLY gt5_txfsmresetdone_r;
        end
    end



    //***********************************************************************//
    //                                                                       //
    //------------------------  Frame Generators  ---------------------------//
    //                                                                       //
    //***********************************************************************//
    // The example design uses Block RAM based frame generators to provide test
    // data to the GTs for transmission. By default the frame generators are 
    // loaded with an incrementing data sequence that includes commas/alignment
    // characters for alignment. If your protocol uses channel bonding, the 
    // frame generator will also be preloaded with a channel bonding sequence.
    
    // You can modify the data transmitted by changing the INIT values of the frame
    // generator in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.

    wire [31:0] GTX_TX_data_FEB1;
    wire        GTX_TX_valid_FEB1;
    RODlink_Data_Encode     GTX_Data_Encode_FEB1_inst                                
    (
        .clk            (gt5_txusrclk2_i),
        .reset          (gt5_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB1),
        .data_valid     (GTX_TX_valid_FEB1),
        .TX_data_out    (gt5_txdata_i)
    );
    
    wire [31:0] GTX_TX_data_FEB2;
    wire        GTX_TX_valid_FEB2;
    RODlink_Data_Encode     GTX_Data_Encode_FEB2_inst                                
    (
        .clk            (gt4_txusrclk2_i),
        .reset          (gt4_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB2),
        .data_valid     (GTX_TX_valid_FEB2),
        .TX_data_out    (gt4_txdata_i)
    );
    
    wire [31:0] GTX_TX_data_FEB3;
    wire        GTX_TX_valid_FEB3;
    RODlink_Data_Encode     GTX_Data_Encode_FEB3_inst                                
    (
        .clk            (gt3_txusrclk2_i),
        .reset          (gt3_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB3),
        .data_valid     (GTX_TX_valid_FEB3),
        .TX_data_out    (gt3_txdata_i)
    ); 
    
    wire [31:0] GTX_TX_data_FEB4;
    wire        GTX_TX_valid_FEB4;
    RODlink_Data_Encode     GTX_Data_Encode_FEB4_inst                                
    (
        .clk            (gt2_txusrclk2_i),
        .reset          (gt2_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB4),
        .data_valid     (GTX_TX_valid_FEB4),
        .TX_data_out    (gt2_txdata_i)
    );    
    
    wire [31:0] GTX_TX_data_FEB5;
    wire        GTX_TX_valid_FEB5;
    RODlink_Data_Encode     GTX_Data_Encode_FEB5_inst                                
    (
        .clk            (gt1_txusrclk2_i),
        .reset          (gt1_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB5),
        .data_valid     (GTX_TX_valid_FEB5),
        .TX_data_out    (gt1_txdata_i)
    );
    
    wire [31:0] GTX_TX_data_FEB6;
    wire        GTX_TX_valid_FEB6;
    RODlink_Data_Encode     GTX_Data_Encode_FEB6_inst                                
    (
        .clk            (gt0_txusrclk2_i),
        .reset          (gt0_tx_system_reset_c | reset),
        .data_in        (GTX_TX_data_FEB6),
        .data_valid     (GTX_TX_valid_FEB6),
        .TX_data_out    (gt0_txdata_i)
    );


    //***********************************************************************//
    //                                                                       //
    //------------------------  Frame Checkers  -----------------------------//
    //                                                                       //
    //***********************************************************************//
    // The example design uses Block RAM based frame checkers to verify incoming  
    // data. By default the frame generators are loaded with a data sequence that 
    // matches the outgoing sequence of the frame generators for the TX ports.
    
    // You can modify the expected data sequence by changing the INIT values of the frame
    // checkers in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.
    
    // When the frame checker receives data, it attempts to synchronise to the 
    // incoming pattern by looking for the first sequence in the pattern. Once it 
    // finds the first sequence, it increments through the sequence, and indicates an 
    // error whenever the next value received does not match the expected value.

    RODlink_Data_Decode     GTX_Data_Decode_FEB1_inst                                // decode data from GTX RX
    (
        .clk                (gt5_rxusrclk2_i),
        .reset              (gt5_rx_system_reset_c | reset),
        .rx_data_in         (gt5_rxdata_i),
        .decoded_data_out   (FEB1_GTX_RX_data),
        .decoded_data_valid (FEB1_GTX_RX_valid),
        .decoded_data_CRC   (FEB1_GTX_RX_CRC),
        .rx_data_aligned    (FEB1_GTX_RX_aligned)
    );
    assign FEB1_GTX_RX_clk = gt5_rxusrclk2_i;

    RODlink_Data_Decode     GTX_Data_Decode_FEB2_inst                                // decode data from GTX RX
    (
        .clk                (gt4_rxusrclk2_i),
        .reset              (gt4_rx_system_reset_c | reset),
        .rx_data_in         (gt4_rxdata_i),
        .decoded_data_out   (FEB2_GTX_RX_data),
        .decoded_data_valid (FEB2_GTX_RX_valid),
        .decoded_data_CRC   (FEB2_GTX_RX_CRC),
        .rx_data_aligned    (FEB2_GTX_RX_aligned)
    );
    assign FEB2_GTX_RX_clk = gt4_rxusrclk2_i;

    RODlink_Data_Decode     GTX_Data_Decode_FEB3_inst                                // decode data from GTX RX
    (
        .clk                (gt3_rxusrclk2_i),
        .reset              (gt3_rx_system_reset_c | reset),
        .rx_data_in         (gt3_rxdata_i),
        .decoded_data_out   (FEB3_GTX_RX_data),
        .decoded_data_valid (FEB3_GTX_RX_valid),
        .decoded_data_CRC   (FEB3_GTX_RX_CRC),
        .rx_data_aligned    (FEB3_GTX_RX_aligned)
    );
    assign FEB3_GTX_RX_clk = gt3_rxusrclk2_i;

    RODlink_Data_Decode     GTX_Data_Decode_FEB4_inst                                // decode data from GTX RX
    (
        .clk                (gt2_rxusrclk2_i),
        .reset              (gt2_rx_system_reset_c | reset),
        .rx_data_in         (gt2_rxdata_i),
        .decoded_data_out   (FEB4_GTX_RX_data),
        .decoded_data_valid (FEB4_GTX_RX_valid),
        .decoded_data_CRC   (FEB4_GTX_RX_CRC),
        .rx_data_aligned    (FEB4_GTX_RX_aligned)
    );
    assign FEB4_GTX_RX_clk = gt2_rxusrclk2_i;

    RODlink_Data_Decode     GTX_Data_Decode_FEB5_inst                                // decode data from GTX RX
    (
        .clk                (gt1_rxusrclk2_i),
        .reset              (gt1_rx_system_reset_c | reset),
        .rx_data_in         (gt1_rxdata_i),
        .decoded_data_out   (FEB5_GTX_RX_data),
        .decoded_data_valid (FEB5_GTX_RX_valid),
        .decoded_data_CRC   (FEB5_GTX_RX_CRC),
        .rx_data_aligned    (FEB5_GTX_RX_aligned)
    );
    assign FEB5_GTX_RX_clk = gt1_rxusrclk2_i;

    RODlink_Data_Decode     GTX_Data_Decode_FEB6_inst                                // decode data from GTX RX
    (
        .clk                (gt0_rxusrclk2_i),
        .reset              (gt0_rx_system_reset_c | reset),
        .rx_data_in         (gt0_rxdata_i),
        .decoded_data_out   (FEB6_GTX_RX_data),
        .decoded_data_valid (FEB6_GTX_RX_valid),
        .decoded_data_CRC   (FEB6_GTX_RX_CRC),
        .rx_data_aligned    (FEB6_GTX_RX_aligned)
    );
    assign FEB6_GTX_RX_clk = gt0_rxusrclk2_i;
    
    assign track_data_out_i = 
                                gt0_track_data_i &
                                gt1_track_data_i &
                                gt2_track_data_i &
                                gt3_track_data_i &
                                gt4_track_data_i &
                                gt5_track_data_i ;

    assign  gt0_track_data_i = 1'b1;
    assign  gt1_track_data_i = 1'b1;
    assign  gt2_track_data_i = 1'b1;
    assign  gt3_track_data_i = 1'b1;
    assign  gt4_track_data_i = 1'b1;
    assign  gt5_track_data_i = 1'b1;


//-------------------------------------------------------------------------------------


//-------------------------Debug Signals assignment--------------------

//------------ optional Ports assignments --------------
 //------GTH/GTP
assign  gt0_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt0_rxpmareset_i                     =  tied_to_ground_i;
 //------GTH/GTP
assign  gt1_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt1_rxpmareset_i                     =  tied_to_ground_i;
 //------GTH/GTP
assign  gt2_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt2_rxpmareset_i                     =  tied_to_ground_i;
 //------GTH/GTP
assign  gt3_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt3_rxpmareset_i                     =  tied_to_ground_i;
 //------GTH/GTP
assign  gt4_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt4_rxpmareset_i                     =  tied_to_ground_i;
 //------GTH/GTP
assign  gt5_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt5_rxpmareset_i                     =  tied_to_ground_i;
//------------------------------------------------------
    // assign resets for frame_gen modules
    assign  gt0_tx_system_reset_c = !gt0_txfsmresetdone_r2;
    assign  gt1_tx_system_reset_c = !gt1_txfsmresetdone_r2;
    assign  gt2_tx_system_reset_c = !gt2_txfsmresetdone_r2;
    assign  gt3_tx_system_reset_c = !gt3_txfsmresetdone_r2;
    assign  gt4_tx_system_reset_c = !gt4_txfsmresetdone_r2;
    assign  gt5_tx_system_reset_c = !gt5_txfsmresetdone_r2;

    // assign resets for frame_check modules
    assign  gt0_rx_system_reset_c = !gt0_rxresetdone_r3;
    assign  gt1_rx_system_reset_c = !gt1_rxresetdone_r3;
    assign  gt2_rx_system_reset_c = !gt2_rxresetdone_r3;
    assign  gt3_rx_system_reset_c = !gt3_rxresetdone_r3;
    assign  gt4_rx_system_reset_c = !gt4_rxresetdone_r3;
    assign  gt5_rx_system_reset_c = !gt5_rxresetdone_r3;

assign gt0_drpaddr_i = 9'd0;
assign gt0_drpdi_i = 16'd0;
assign gt0_drpen_i = 1'b0;
assign gt0_drpwe_i = 1'b0;
assign gt1_drpaddr_i = 9'd0;
assign gt1_drpdi_i = 16'd0;
assign gt1_drpen_i = 1'b0;
assign gt1_drpwe_i = 1'b0;
assign gt2_drpaddr_i = 9'd0;
assign gt2_drpdi_i = 16'd0;
assign gt2_drpen_i = 1'b0;
assign gt2_drpwe_i = 1'b0;
assign gt3_drpaddr_i = 9'd0;
assign gt3_drpdi_i = 16'd0;
assign gt3_drpen_i = 1'b0;
assign gt3_drpwe_i = 1'b0;
assign gt4_drpaddr_i = 9'd0;
assign gt4_drpdi_i = 16'd0;
assign gt4_drpen_i = 1'b0;
assign gt4_drpwe_i = 1'b0;
assign gt5_drpaddr_i = 9'd0;
assign gt5_drpdi_i = 16'd0;
assign gt5_drpen_i = 1'b0;
assign gt5_drpwe_i = 1'b0;
assign soft_reset_i = tied_to_ground_i;
endmodule
