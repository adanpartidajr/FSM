module FSM_pv(input KEY0, SW0, SW1, SW2, SW3, SW4, output logic [6:0] HEX0, HEX1, HEX2, HEX3, output logic [6:0] LED_SW);
logic [7:0] Message [4:0];
logic [2:0] state;
logic [1:0] Z;

assign LED_SW [4:0] = {SW4, SW3, SW2, SW1, SW0};
assign LED_SW [6:5] = Z;

FSM F1 (KEY0, SW0, SW1, SW2, SW3, SW4, state, Z);
ASCII27Seg SevH3 (Message[3], HEX3);
ASCII27Seg SevH2 (Message[2], HEX2);
ASCII27Seg SevH1 (Message[1], HEX1);
ASCII27Seg SevH0 (Message[0], HEX0);

always_comb
	 begin		
		Message[3] = "P";
		Message[2] = "a";
		Message[1] = "r";
		Message[0] = "t";
				
		case (state)
			3'b000 : begin
				Message[3] = "P";
				Message[2] = "a";
				Message[1] = "r";
				Message[0] = "t";
				end

			3'b001 : begin
				Message[3] = "S";
				Message[2] = "_";
				Message[1] = "0";
				Message[0] = "1";
				end

			3'b010 : begin
				Message[3] = "S";
				Message[2] = "_";
				Message[1] = "0";
				Message[0] = "2";
				end
				
			3'b011 : begin
				Message[3] = "S";
				Message[2] = "_";
				Message[1] = "0";
				Message[0] = "3";
				end

			3'b100 : begin
				Message[3] = "S";
				Message[2] = "_";
				Message[1] = "0";
				Message[0] = "4";
				end	

			default : begin
			//Default sets Message in every case
				Message[3] = "P";
				Message[2] = "a";
				Message[1] = "r";
				Message[0] = "t";
				end
		endcase
	end
endmodule

module FSM(input key0, sw0, sw1, sw2, sw3, sw4, output logic [2:0] state, output logic [1:0] Z);
localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
logic [2:0] next_state;

always_ff @ (posedge key0)
	begin
		if (sw0)
			state <= S0;
		else
			state <= next_state;
	end

always_comb 
	begin
		next_state = state;
		Z = 2'b01;
		case(state)
			S0 : begin
					Z = 2'b01;
					if (sw2) 
						next_state = S1;
					else if (sw3)
						next_state = S3;
				end
			 
			S1 : begin Z = 2'b10; next_state = (sw1) ? S2 : S1; end
			 
			S2 : begin
					Z = 2'b00;
					if (sw1) 
						next_state = S1;
					else if (sw4)
						next_state = S3;
				end
			 
			S3 : begin
					Z = 00;
					if (sw3) 
						next_state = S4;
					else if (sw1)
						next_state = S1;
				end
			 
			S4 : begin Z = 2'b11; next_state = (sw1) ? S1 : S4; end
			 
			default : begin next_state = S0; Z = 2'b01; end
		endcase
	end
endmodule

module debounce3 #(parameter cntSize = 8)
( 
input reset,
input Clk,
input PB,
output logic pulse
);

logic [cntSize-1:0] cnt;
always_ff @(posedge Clk)
	if (reset)
		cnt <= {cntSize{1'b0}};
	else
		begin
			cnt <= {cnt[cntSize-2:0], PB};
			if ( &cnt )		pulse <= 1'b1;
			else if (~|cnt) pulse <= 1'b0;
		end
endmodule