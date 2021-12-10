module top_turn (
    input clk, rst,
    input [12-1:0] keypad_in,
    output l0, l1, l2, l3, l4, l5, l6, l7,l8,l9,l10
);
    wire [4-1:0] keypad_scan;
    wire en, whose;
    wire [8-1:0] count;


keypad_scan scn(.clk(clk), .rst(rst), .keypad_in(keypad_in), .scan_out(keypad_scan));
turn tunr(.clk(clk), .rst(rst), .keypad_in(keypad_scan), .en(en), .whose(whose));
pseudo_random rgen(.clk(clk), .rst(rst), .en(en), .rnd({l3, l4, l5, l6, l7}));
//counter c1(.clk(clk), .rst(rst), .en(en), .finish(1'b0), .count(count));

assign {l0, l1, l2} = {en, whose, 1'b1};

endmodule