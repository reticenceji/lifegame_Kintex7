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
	
	
	assign usr_op = op;
	//TODO: translate xkey to op, use switch-case
	always @ (posedge clk or negedge rst) begin
		if (!rst) begin
			op<=0;
		end
		else begin
			case (xkey[7:0])
				8'h1D: op<=1;	//W
				8'h1B: op<=2;	//S
				8'h1C: op<=3;	//A
				8'h23: op<=4;	//D
				8'h5A: op<=5;	//Enter
				8'h55: op<=6;	//=
				8'h4E: op<=7;	//-
				8'h29: op<=8;	//Space
				default: op<=0;	//other
			endcase
		end
	end
endmodule
