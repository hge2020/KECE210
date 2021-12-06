module tb_counter;
reg clk, rst;
reg en;
wire [8-1:0] count;

counter tbcounter (.clk(clk), .rst(rst), .en(en), .count(count));

initial begin
    clk <= 1'b1;
    rst <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin
    #10 rst <= ~rst;
    #200 rst <= ~rst;
    #100 $finish;
end

initial begin
    #20 en <= 1'b1;
    #20 en <= 1'b0;
    #100 en <= 1'b1;
    #20 en <= 1'b0;
end

endmodule
