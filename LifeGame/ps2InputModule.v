`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:11 12/31/2020 
// Design Name: 
// Module Name:    ps2InputModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: call keyboard
//
//////////////////////////////////////////////////////////////////////////////////
module ps2InputModule(clk, rst,
							 ps2_clk, ps2_data,
							 usr_op);

	input wire clk, rst;
	input wire ps2_clk, ps2_data;
	output wire [3:0] usr_op;
	
	reg [3:0] op;
	assign usr_op = op;
	
	wire [15:0] xkey;
	keyboard kbd(clk, rst, ps2_clk, ps2_data, xkey);
	
	//TODO: translate xkey to op, use switch-case

endmodule
