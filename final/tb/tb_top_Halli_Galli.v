module tb_top_Halli_Galli;
    reg clk, rst;
    reg b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12;
    wire led_1_r, led_1_g, led_1_b, led_2_r, led_2_g, led_2_b;
    wire [7-1:0] seg_display;
    wire [8-1:0] seg_position;
    wire LCD_E, LCD_RS, LCD_RW;
    wire [7:0] LCD_DATA;

    top_Halli_Galli simul(
        .clk(clk), .rst(rst),
        .b1(b1), .b2(b2), .b3(b3), .b4(b4), .b5(b5), .b6(b6), .b7(b7), .b8(b8), .b9(b9), .b10(b10), .b11(b11), .b12(b12),
        .led_1_r(led_1_r), .led_1_g(led_1_g), .led_1_b(led_1_b), .led_2_r(led_2_r), .led_2_g(led_2_g), .led_2_b(led_2_b),
        .seg_display(seg_display), .seg_position(seg_position),
        .LCD_E(LCD_E), .LCD_RS(LCD_RS), .LCD_RW(LCD_RW),
        .LCD_DATA(LCD_DATA)
    );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        b1 <= 1'b0;
        b2 <= 1'b0;
        b3 <= 1'b0;
        b4 <= 1'b0;
        b5 <= 1'b0;
        b6 <= 1'b0;
        b7 <= 1'b0;
        b8 <= 1'b0;
        b9 <= 1'b0;
        b10 <= 1'b0;
        b11 <= 1'b0;
        b12 <= 1'b0;        
        forever #10 clk <= ~clk;
    end

    initial begin
        #5 rst <= 1'b1;

        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;

        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;

        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;
        
        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;

        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;

        #14 b1 <= 1'b1; // press '1'
        #14 b1 <= 1'b0;

        #14 b3 <= 1'b1; // press '3'
        #14 b3 <= 1'b0;

        #50 rst <= 1'b0;
    end
endmodule