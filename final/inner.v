module turn (
    input clk, rst,
    input [4-1:0] keypad_in,
    output reg en, whose
);
parameter turn1 = 1'b0;
parameter turn2 = 1'b1;

reg finite_state;

always @(posedge clk) begin
    if (!rst) begin
        finite_state <= turn1;
    end
end

always @(posedge clk) begin
    case(finite_state)
    turn1: begin
        if (keypad_in == 4'b0011) begin
            finite_state <= turn2;
            en <= 1'b1;
            whose <= 1'b1;
        end
        else begin
            finite_state <= turn1;
            en <= 1'b0;
            whose <= 1'b0;
        end
    end
    turn2: begin
        if (keypad_in == 4'b0001) begin
            finite_state <= turn1;
            en <= 1'b1;
            whose <= 1'b0;
        end
        else begin
            finite_state <= turn2;
            en <= 1'b0;
            whose <= 1'b1;
        end
    end
    default: finite_state <= turn1;
    endcase
end

endmodule



module counter (
    input clk, rst,
    input en,
    output reg [8-1:0] count
);
always @(posedge clk) begin
    if (!rst) begin
        count <= 8'b0;
    end
end

always @(posedge en) begin //이거밖에 없어도 클락에서 안뜯어져서움직이나..?
    count = count +1'b1; //아웃풋에ezr해도됨...?
end

endmodule



module rand_gen (
    input clk, rst,
    input en,
    output wire [5-1:0] rnd
);
    reg [5-1:0] q, nxt_q;
    reg feedback;

assign rnd = q;

always @(posedge clk, negedge rst) begin
    if (!rst) q <= 5'b11100;
    else begin
        q <= nxt_q;
    end
end

always @(*) begin
    nxt_q = q << 1;
    nxt_q[0] = q[2] ^ q[4];
end

endmodule



module card_value (
    input clk, rst,
    input [5-1:0] rnd
    output [2-1:0] color,
    output [3-1:0] number
);
    reg [2-1:0] r_color;
    reg [3-1:0] r_number;

assign color = r_color;
assign number = r_number;

always @(posedge clk) begin
    if (!rst) begin
        r_color <= 2'b0;
        r_number <= 3'b0;
    end
end

always @(*) begin
    r_color <= (rnd[4:3] %3) + 1'b1;
    r_number <= rnd[2:0] %5;
end

endmodule



