module LFSR (
    input clk,
    input rst,
    output reg [4:0] rnd
);
    reg [4:0] q, nxt_q;
    reg feedback;
always @(posedge clk, negedge rst) begin
    if (!rst) rnd <= 5'b00000;
    else begin
        // q[4:1] <= q[3:0];
        // q[0] <= feedback;
        q <= nxt_q;
    end
    rnd <= q;
end

always @(*) begin
    //feedback = q[2] ^ q[4];
    nxt_q = q << 1;
    nxt_q[0] = q[2] ^ q[4];
end

endmodule
