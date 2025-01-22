`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/05 18:53:02
// Design Name: 
// Module Name: FEB_Trigger
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


module FEB_Trigger(
input   reset,
input   sync_clk,
input   self_trigger,
input   external_trigger,
output  Trigger_FEB
    );
    
reg  external_trigger_r0    = 1'b0;
reg  external_trigger_r1    = 1'b0;
reg  self_trigger_r0        = 1'b0;
reg  self_trigger_r1        = 1'b0;
always@(posedge sync_clk)
    begin
        external_trigger_r0 <= external_trigger;
        external_trigger_r1 <= external_trigger_r0;
        self_trigger_r0     <= self_trigger;
        self_trigger_r1     <= self_trigger_r0;
    end
 
reg [2:0]   external_trigger_counter = 3'b000;
reg         external_trigger_pulse   = 1'b0;
always@(posedge sync_clk)
    begin
        if(reset)
            begin
                external_trigger_counter <= 3'b000;
                external_trigger_pulse   <= 1'b0;
            end
        else if((external_trigger_r0 == 1'b1)&&(external_trigger_r1 == 1'b0))   //raising edge of external_trigger
            begin
                external_trigger_counter <= 3'b001;
                external_trigger_pulse   <= 1'b1;            
            end
        else if((external_trigger_counter > 3'b000)&&(external_trigger_counter < 3'b111))
            begin
                external_trigger_counter <= external_trigger_counter + 1'b1;
                external_trigger_pulse   <= 1'b1;                
            end
        else
            begin
                external_trigger_counter <= 3'b000;
                external_trigger_pulse   <= 1'b0;
            end        
    end 
 
reg [1:0]   trigger_counter = 2'b00;
reg         trigger_FEB_r   = 1'b0;
reg         trigger_busy    = 1'b0;
always@(posedge sync_clk)
    begin
        if(reset)
            begin
                trigger_counter <= 2'b00;
                trigger_FEB_r   <= 1'b0;
                trigger_busy    <= 1'b0;
            end
        else if(trigger_counter == 2'b00)
            begin
                if(((external_trigger_pulse == 1'b1)||(self_trigger_r1 == 1'b1))&&(trigger_busy == 1'b0)) trigger_busy <= 1'b1;            // external_trigger or self_trigger == 1'b1
                else trigger_busy <= 1'b0;
                trigger_FEB_r   <= 1'b0;     
                trigger_counter <= 2'b01;    
            end     
        else if(trigger_counter == 2'b01)
            begin
                if(trigger_busy == 1'b1) trigger_FEB_r <= 1'b1;
                else trigger_FEB_r <= 1'b0;
                trigger_busy    <= trigger_busy;
                trigger_counter <= 2'b10; 
            end
        else if(trigger_counter == 2'b10)
            begin
                if(trigger_busy == 1'b1) trigger_FEB_r <= 1'b0;
                else trigger_FEB_r <= 1'b1;
                trigger_busy    <= trigger_busy;
                trigger_counter <= 2'b11;            
            end
        else if(trigger_counter == 2'b11)
            begin
                trigger_FEB_r   <= 1'b1;
                trigger_busy    <= trigger_busy;
                trigger_counter <= 2'b00;            
            end      
        else
            begin
                trigger_FEB_r   <= 1'b0;
                trigger_counter <= 2'b00;   
                trigger_busy    <= 1'b0;          
            end      
    end 

assign  Trigger_FEB = trigger_FEB_r;    
  

//wire [15:0] probe0;
//assign  probe0 = {external_trigger_r0,external_trigger_r1,self_trigger_r0,self_trigger_r1,external_trigger_counter,external_trigger_pulse,trigger_counter,trigger_FEB_r,trigger_busy};
  
//ila_0   ila0_inst
//(
//.clk(sync_clk),
//.probe0(probe0)
//);    
    
endmodule
