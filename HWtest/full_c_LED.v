module full_c_LED (
input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12,
output  led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b
);

reg [11:0] out;

initial begin
    led_1_r <= 1'b0;
    led_1_g <= 1'b0;
    led_l_b <= 1'b0;
    led_2_r <= 1'b0;
    led_2_g <= 1'b0;
    led_2_b <= 1'b0;
    led_3_r <= 1'b0;
    led_3_g <= 1'b0;
    led_3_b <= 1'b0;
    led_4_r <= 1'b0;
    led_4_g <= 1'b0;
    led_4_b <= 1'b0;
end

always @(*) begin
    out <= {b12, b11, b10, b9, b8, b7, b6, b5, b4, b3, b2, b1};
end

assign {led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b} = out;

endmodule