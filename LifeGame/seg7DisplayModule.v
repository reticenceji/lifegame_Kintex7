`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:10:07 12/31/2020 
// Design Name: 
// Module Name:    ledDisplayModule 
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
module seg7DisplayModule(clk, rst,
								game_mode,
								generation,
								cell_a, cell_b,
								cell_total,
								seg_clk, seg_sout,
								SEG_PEN, seg_clrn
								);
	input wire clk, rst;
	input wire game_mode;
	input wire [12:0] generation;
	input wire [7:0] cell_a, cell_b;
	input wire [15:0] cell_total;
	output wire seg_clk, seg_sout, SEG_PEN, seg_clrn;
	
	wire [31:0] div;
	clkdiv cd(clk, rst, div);
	
	SSeg7_Dev seg7(.clk(clk),.rst(1'b0),.Start(div[20]),.SW0(1'b0),.flash(1'b0),
						.Hexs({3'b000, generation, game_mode==0?cell_total:{cell_a,cell_b}}),.point(8'b0000_0000),
						.LES(8'b0000_0000),.seg_clk(seg_clk),.seg_sout(seg_sout),.SEG_PEN(SEG_PEN),.seg_clrn(seg_clrn));
endmodule
