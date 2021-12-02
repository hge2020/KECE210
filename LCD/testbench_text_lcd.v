module tb_text_lcd;
    reg clk, rst;
    wire RW, RS, EN;
    wire [8-1:0] DATA;

    LCD lcd(
        .resetn(rst), .clk(clk),
        .LCD_E(EN),
        .LCD_RS(RS), .LCD_RW(RW),
        .LCD_DATA(DATA)
    );

    initial begin
        /*
            Initialization Clock and Reset port.
        */
        clk <= 1'b1;
        rst <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        #8000 rst <= ~rst;
        #100 $finish;
    end

endmodule