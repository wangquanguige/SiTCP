`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/07 21:46:21
// Design Name: 
// Module Name: sim_2
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
/*`timescale 1ps / 1ps

module sim_2(

    );

wire test = 64'h0102030405060708;
wire test_reg = 32'h090a0b0c;
$display("wr_axis_tdata %h", test[15:0]);

endmodule*/

`timescale 1ns/1ps

module test ;
   reg          clk ;
   reg [63:0] testt ;
   reg [15:0] test_reg ;

   initial begin
      clk = 0 ;
   end
   always #(10/2)   clk = ~clk ;

   //$display
   reg [3:0]         num ;
   initial begin
      num  = 1 ;
      $display("This is a test.");
      $display("This is a test number: %b.", num);
      $display("This is a test number: ", num, "!!!");
   end

   //$write
   initial begin
      #4 ;
      $write("This is a test");
      $write("number: %b", num);
      $write("!!!\n");
   end

   //$strobe
   reg [3:0]  a ;
   initial begin
      a = 1 ;
      #1 ;
      a <= a + 1 ;
      $display("$display excuting result: %d.", a);
      $strobe("$strobe excuting result: %d.", a);
      #1 ;
      $display();
      $display("$display excuting result: %d.", a);
      $strobe("$strobe excuting result: %d.", a);
   end

   integer  i ;
   initial begin
      #8 ;
      for (i=0; i<4; i=i+1) begin
         $display("Run times of $display: %d.", i);
         $strobe("Run times of $strobe: %d.", i);
      end
   end


   //$monitor
   reg [3:0]    cnt ;
   initial begin
      cnt = 3 ;
      forever begin
         # 5 ;
         if (cnt<7) cnt = cnt + 1 ;
      end
   end

   initial begin
      $monitor("Counter change to value %d at the time %t.", cnt, $time);
   end



   initial begin

      testt = 64'h0102030405060708;
      test_reg = testt[63:48];
      $display("wr_axis_tdata %h %h", testt, test_reg);

      forever begin
         #100;
         if ($time >= 10000)  $finish ;
      end
      
      testt = 64'h0102030405060708;
      test_reg = testt[15:0];
      $display("wr_axis_tdata %h", test_reg);

   end

   

endmodule // test

