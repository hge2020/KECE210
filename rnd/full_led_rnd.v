module full_c_LED (
input [12:0] b,
output  led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b
);

always @(*) begin
    out <= b;
end

assign {led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b} = out;

endmodule

module top_full_led_rnd(
    input clk, rst,
    output led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b);

    wire [12:0] rnd;

    LFSR rand(.clock(clk), .reset(rst), .rnd(rnd));
    full_c_LED fled(rnd[11:0],
        led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b)

endmodule