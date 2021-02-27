`timescale 1ns/1ps

module fsmtb();
logic clk = 0, SW0 = 0, SW1 = 0, SW2 = 0, SW3 = 0, SW4 = 0;
logic [1:0] Z = 2'b00;
logic [2:0] state = 3'b000;

FSM fsm1 (KEY0, SW0, SW1, SW2, SW3, SW4, state, Z);

initial begin

clk = 0; SW0 = 0;	#10;	
clk = 1; SW0 = 1;	#10;

clk = 0; SW0 = 0;	#10;	
clk = 1; SW2 = 1;	#10;

clk = 0; SW2 = 0;	#10;	
clk = 1; SW1 = 1;	#10;

clk = 0; SW1 = 0;	#10;	
clk = 1; SW1 = 1;	#10;

clk = 0; SW1 = 0;	#10;	
clk = 1; SW1 = 1;	#10;

clk = 0; SW1 = 0;	#10;	
clk = 1; SW4 = 1;	#10;

clk = 0; SW4 = 0;	#10;	
clk = 1; SW3 = 1;	#10;

clk = 0; SW3 = 0;	#10;	
clk = 1; SW1 = 1;	#10;

clk = 0; SW1 = 0;	#10;

end
endmodule