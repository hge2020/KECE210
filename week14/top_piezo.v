module top_piezo_tone(
    input clk, rst,
    input [12-1:0] keypad_in,
    output sound_out
);
    integer counter_sound;
    integer sound_limit;
	reg buffer;

	always @ (keypad_in) begin
		case (keypad_in)
            12'b000000000001: sound_limit = 1910; //C
            12'b000000000010: sound_limit = 1701; //D
            12'b000000000100: sound_limit = 1516; //E
            12'b000000001000: sound_limit = 1431; //F
            12'b000000010000: sound_limit = 1275; //G
            12'b000000100000: sound_limit = 1135; //A
            12'b000001000000: sound_limit = 1011; //B
            12'b000010000000: sound_limit = 955; //C
		    default: sound_limit = 0; //no sound
		endcase
	end

	always@(posedge clk or negedge rst)begin
		if (~rst) begin
			buffer <= 1'b0;
			counter_sound = 0;
		end
        else begin
            if (counter_sound >= sound_limit) begin
				counter_sound = 0;
				buffer <= ~buffer;
			end
			else counter_sound = counter_sound +1;
        end
	end
	assign sound_out = buffer;

endmodule
