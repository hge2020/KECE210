module tb_full_c_LED(
input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12
output  led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b;

full_c_LED fl(input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12,
        led_1_r, led_1_g, led_1_b,
        led_2_r, led_2_g, led_2_b,
        led_3_r, led_3_g, led_3_b,
        led_4_r, led_4_g, led_4_b);

endmodule