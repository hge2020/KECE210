module LFSR (
    input clk,
    input rst,
    output wire [4:0] rnd
);
    reg [4:0] q, nxt_q;
    reg feedback;

assign rnd = q;

always @(posedge clk, negedge rst) begin
    if (!rst) q <= 5'b11100;
    else begin
        // q[4:1] <= q[3:0];
        // q[0] <= feedback;
        q <= nxt_q;
    end
end

always @(*) begin
    //feedback = q[2] ^ q[4];
    nxt_q = q << 1;
    nxt_q[0] = q[2] ^ q[4];
end

endmodule
