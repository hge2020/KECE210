module tb_keypad_scan;
    reg [12-1:0] virtual_key_input;
    reg clk, rst;
    wire [7-1:0] seg_display;
    wire [8-1:0] seg_position;

    top_keypad simul(
            .clk(clk), .rst(rst), .keypad_in( virtual_key_input ),
            .seg_display( seg_display ), .seg_position( seg_position )
        );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        forever #1 clk <= ~clk;
    end

    initial begin
        #5 rst <= 1'b1;
        #5 virtual_key_input <= 12'b0000_0000_0001; // press '1'
        #5 virtual_key_input <= 12'bx;
        #10 virtual_key_input <= 12'b1000_0000_0000; // press '#'
        #5 virtual_key_input <= 12'bx;
        #10 virtual_key_input <= 12'b0000_0000_0010; // press '2'
        #5 virtual_key_input <= 12'bx;
        #10 virtual_key_input <= 12'b0100_0000_0000; // press '*'
        #5 virtual_key_input <= 12'bx;
        #70 rst <= 1'b0;
        #2 rst <= 1'b1;
        #30 $finish;
    end

endmodule