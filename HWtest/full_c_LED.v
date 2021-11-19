module full_c_LED (
input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12
output  led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b;
);

always @(*) begin
    case({b12, b11, b10, b9, b8, b7, b6, b5, b4, b3, b2, b1})
	12'b0000_0000_0001 : led_1_r <= 1'b1;
	12'b0000_0000_0010 : led_1_g <= 1'b1;
	12'b0000_0000_0100 : led_1_b <= 1'b1;
	12'b0000_0000_1000 : led_2_r <= 1'b1;
	12'b0000_0001_0000 : led_2_g <= 1'b1;
	12'b0000_0010_0000 : led_2_b <= 1'b1;
	12'b0000_0100_0000 : led_3_r <= 1'b1;
	12'b0000_1000_0000 : led_3_g <= 1'b1;
	12'b0001_0000_0000 : led_3_b <= 1'b1;
	12'b0010_0000_0000 : led_4_r <= 1'b1;
    12'b0100_0000_0000 : led_4_r <= 1'b1;
    12'b1000_0000_0000 : led_4_r <= 1'b1;
endcase 
end

endmodule