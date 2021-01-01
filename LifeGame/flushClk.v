`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:31 12/31/2020 
// Design Name: 
// Module Name:    flushClk 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module flushClk(clk, rst, clk_out, usr_op);
	input wire clk;
	input wire rst;
	input wire [3:0] usr_op;
	output reg clk_out;
	
	reg [31:0] cnt;
	always @ (posedge clk or negedge rst) begin
	     if (!rst) begin
		      cnt=0;
				clk_out=0;
		  end
		  else begin
			  if (cnt==1_500_000) begin	//cnt==xxx depends on our need
					cnt=0;
					clk_out=~clk_out;
			  end
			  else begin
					cnt=cnt+1;
			  end
		  end
	 end

endmodule
