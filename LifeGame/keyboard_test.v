`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:49:16 01/03/2021
// Design Name:   keyboard
// Module Name:   /home/reticence/code/lifegame_Kintex7/LifeGame/keyboard_test.v
// Project Name:  LifeGame
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: keyboard
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module keyboard_test;

	// Inputs
	reg clk_25mhz;
	reg clr;
	reg PS2C;
	reg PS2D;

	// Outputs
	wire [15:0] xkey;

	// Instantiate the Unit Under Test (UUT)
	keyboard uut (
		.clk_25mhz(clk_25mhz), 
		.clr(clr), 
		.PS2C(PS2C), 
		.PS2D(PS2D), 
		.xkey(xkey)
	);

	initial begin
		// Initialize Inputs
		clk_25mhz = 0;
		clr = 0;
		PS2C = 0;
		PS2D = 1;
		#100;
	end
		// Wait 100 ns for global reset to finish
		
	always
	begin
		PS2D=0; #50;	//Start	

		PS2D=0;
		#50;
		PS2D=0;
		#50;
		PS2D=0;
		#50;
		PS2D=1;
		#50;
		PS2D=1;
		#50;
		PS2D=0;
		#50;
		PS2D=1;
		#50;
		PS2D=1;
		#50;				//DATA
		
		PS2D=1;
		#50;				//Check
		PS2D=1;
		#800;			//Stop
	end
	
	always 
	begin
		PS2C=1;
		#25;
		PS2C=0;
		#25;
	end
	
	always 
	begin
		clk_25mhz=1;
		#6.25;
		clk_25mhz=0;
		#6.25;
	end
	
	// Add stimulus here
      
endmodule

