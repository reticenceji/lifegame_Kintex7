`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:34 12/31/2020 
// Design Name: 
// Module Name:    top 
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
module top(clk, rst, 			//global clk is 100MHz
			  ps2_clk, ps2_data,	//for processing keyboard input
			  hs, vs, r, g, b,	//for vga display
			  seg_clk, seg_sout,
			  SEG_PEN, seg_clrn	//for digit display
			  );	
			  
	input wire clk, rst;
	input wire ps2_clk, ps2_data;
	
	output wire hs,vs;
	output wire [3:0] r,g,b;
	output wire seg_clk, seg_sout, SEG_PEN, seg_clrn;
	
	wire clk_out;
	wire [3:0] usr_op;
	
	wire game_mode;
	wire [12:0] generation;
	wire [7:0] cell_a, cell_b;
	wire [15:0] cell_total;
	
	//TODO: determine the input and output port for all modules
	flushClk fclk(clk, rst, usr_op, clk_out);
	imgDisplayModule imgDisp();
	seg7DisplayModule seg7Disp(clk, rst, game_mode, generation, cell_a, cell_b, cell_total,
									 seg_clk, seg_sout, SEG_PEN, seg_clrn);
	ps2InputModule ps2In(clk, rst, ps2_clk, ps2_data, usr_op);
	
	gameLogicModule gameCtrl();
	
endmodule
