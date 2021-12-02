module LFSR (
    input clk,
    input reset,
    output [4:0] rnd
);
    reg q[4:0];
    wire feedback;
always @(posedge clk, negedge rst) begin
    if (!rst) rnd <= 0;
    else begin
        q[0] <= feedback;
        q[4:1] <= q[3:0];
    end
end

always @(*) begin
    feedback = q[2] ^ q[4];
end

assign rnd = q;

endmodule


endmodule