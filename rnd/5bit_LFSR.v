module LFSR (
    input clk,
    input rst,
    output reg [4:0] rnd
);
    reg [4:0] q;
    reg feedback;
always @(posedge clk, negedge rst) begin
    if (!rst) rnd <= 0;
    else begin
        q[4:1] <= q[3:0];
        q[0] <= feedback;
    end
    rnd <= q;
end

always @(*) begin
    feedback = q[2] ^ q[4];
end

endmodule
