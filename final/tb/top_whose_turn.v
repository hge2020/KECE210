module top_turn (
    input clk, rst,
    input [12-1:0] keypad_in,
    output l0, l1, l2, l3, l4, l5, l6, l7
);
    wire [4-1:0] keypad_scan;
    wire en, whose;
    wire demmy;


keypad_scan scn(.clk(clk), .rst(rst), .keypad_in(keypad_in), .scan_out(keypad_scan), .valid(dummy));
turn tunr(.clk(clk), .rst(rst), .keypad_in(keypad_scan), .en(en), .whose(whose));

assign {l0, l1, l2, l3, l4, l5, l6, l7} = {en, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, whose};

endmodule