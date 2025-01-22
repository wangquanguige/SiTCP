`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/30 20:19:50
// Design Name: 
// Module Name: axi_10g_ethernet_0_arp_control
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


module axi_10g_ethernet_0_arp_control #(
    parameter           show_output_block           =           1           
)
(
    input                               aclk                     ,
    input                               areset                   ,

    // arp_request控制信号
    input                               arp_request_en           ,
    output      reg                     arp_request_tready       ,
    input                               arp_request_done         ,
 
    // arp_reply控制信号
    input                               arp_reply_en             ,
    output      reg                     arp_reply_tready         ,
    input                               arp_reply_done           ,
 
    // arp_request传输数据
    input               [63:0]          arp_reply_tdata          ,
    input               [7:0]           arp_reply_tkeep          ,
    input                               arp_reply_tvalid         ,
    input                               arp_reply_tlast          ,

    // arp_reply传输数据
    input               [63:0]          arp_request_tdata        ,
    input               [7:0]           arp_request_tkeep        ,
    input                               arp_request_tvalid       ,
    input                               arp_request_tlast        ,

    // 经control模块控制后的实际传输数据
    output      reg     [63:0]          tx_axis_tdata            ,
    output      reg     [7:0]           tx_axis_tkeep            ,
    output      reg                     tx_axis_tvalid           ,
    output      reg                     tx_axis_tlast            ,
    input                               tx_axis_tready           
);

// arp_reply arp_request模块需要发送报文时，各自en信号有效，在本模块内按照request优先级大于reply策略，基于tready信号回复
always @(posedge aclk) begin
    if (areset) begin
        arp_request_tready          <=          0           ;
        arp_reply_tready            <=          0           ;
    end 

    if (arp_reply_tready == 0 & arp_request_tready == 0) begin
        if (arp_request_en) begin
            arp_request_tready          <=          1           ;
            arp_reply_tready            <=          0           ;
        end
        else if (arp_reply_en) begin
            arp_request_tready          <=          0           ;
            arp_reply_tready            <=          1           ;
        end
        else begin
            arp_request_tready          <=          0           ;
            arp_reply_tready            <=          0           ;
        end
    end

    if (arp_reply_done) begin
        arp_reply_tready            <=          0           ;
    end 

    if (arp_request_done) begin
        arp_request_tready          <=          0           ;
    end 
end

always @(posedge aclk) begin
    if (arp_request_tready == 1) begin
        tx_axis_tdata               <=          arp_request_tdata           ; 
        tx_axis_tkeep               <=          arp_request_tkeep           ;
        tx_axis_tvalid              <=          arp_request_tvalid          ;
        tx_axis_tlast               <=          arp_request_tlast           ;

        if (show_output_block == 1) begin
            $display("Now arp_request_block is outputting, data is %h", arp_request_tdata);
        end
    end
    else if (arp_reply_tready == 1) begin
        tx_axis_tdata               <=          arp_reply_tdata             ; 
        tx_axis_tkeep               <=          arp_reply_tkeep             ;
        tx_axis_tvalid              <=          arp_reply_tvalid            ;
        tx_axis_tlast               <=          arp_reply_tlast             ;

        if (show_output_block == 1) begin
            $display("Now arp_reply_block is outputting, data is %h", arp_reply_tdata);
        end
    end
    else begin
        tx_axis_tdata               <=          0                           ; 
        tx_axis_tkeep               <=          0                           ;
        tx_axis_tvalid              <=          0                           ;
        tx_axis_tlast               <=          0                           ;
    end
end

endmodule
