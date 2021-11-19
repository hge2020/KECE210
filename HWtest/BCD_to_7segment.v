module BCD_to_7segment(
	D9, D8, D7, D6, D5, D4, D3, D2, D1, D0,
	A,B,C,D,E,F,G
);
input D9, D8, D7, D6, D5, D4, D3, D2, D1, D0;
output A,B,C,D,E,F,G;

reg [7:0] out;

always @(D9, D8, D7, D6, D5, D4, D3, D2, D1, D0)
begin
case({1'b0, 1'b0, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0})
	12'b0000_0000_0001 : out <= 7'b1111110; //0
	12'b0000_0000_0010 : out <= 7'b0110000; //1
	12'b0000_0000_0100 : out <= 7'b1101101; //2
	12'b0000_0000_1000 : out <= 7'b1111001; //3
	12'b0000_0001_0000 : out <= 7'b0110011; //4
	12'b0000_0010_0000 : out <= 7'b1011011; //5
	12'b0000_0100_0000 : out <= 7'b1011111; //6
	12'b0000_1000_0000 : out <= 7'b1110010; //7
	12'b0001_0000_0000 : out <= 7'b1111111; //8
	12'b0010_0000_0000 : out <= 7'b1111011; //9
	default : out <= 7'b0000000; //NULL
endcase 
end

assign {A,B,C,D,E,F,G} = out;

endmodule