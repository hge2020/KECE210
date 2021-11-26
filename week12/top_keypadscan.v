module top_keypadscan(
    input clk, rst,
    input [12-1:0] keypad_in,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position
);
    wire valid, dis_enable;
    wire [12-1:0] scan_out;
    wire [56-1:0] seg;
    wire [56-1:0] reg_seg;


    keypad_scan ksan( 
            .clk(clk), .rst(rst), .keypad_in(keypad_in), 
            .scan_out(scan_out), .valid(valid) 
        );
    display dis(
            .clk(clk), .rst(rst), .valid(valid), .scan_data( scan_out ), 
            .seg( seg ), .out_en( dis_enable )
        );
    register_file regf(
            .clk(clk), .rst(rst), .en( dis_enable ), .in( seg ),
            .out( reg_seg )
        );
    segment_controller segctrl(
            .clk(clk), .rst(rst), .seg( reg_seg ),
            .data_out( seg_display ), .data_pos( seg_position )
        );

endmodule