module led (clk, led_out);

input clk;
output reg [7:0] led_out;

initial begin
    led_out = 8'b0000_0000;
end

always @(negedge clk) begin
    led_out = $urandom;
end

endmodule