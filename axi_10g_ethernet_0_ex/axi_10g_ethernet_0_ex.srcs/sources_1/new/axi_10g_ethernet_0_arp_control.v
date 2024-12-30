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


module axi_10g_ethernet_0_arp_control(
    input                   aclk                  ,
    input                   areset                ,

    input                   arp_request_en        ,
    output    reg           arp_request_tready    ,
    input                   arp_request_done      ,

    input                   arp_reply_en          ,
    output    reg           arp_reply_tready      ,
    input                   arp_reply_done        
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

endmodule
