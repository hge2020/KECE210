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

endmodule //검증완료



module counter (
        input clk, rst,
        input en, finish,
        output reg [8-1:0] count
    );
    always @(posedge clk) begin
        if (!rst) begin
            count <= 8'b0;
        end
        else if (finish) begin
            count <= 8'b0;
        end
    end

    always @(posedge en) begin
        count = count +1'b1;
    end

endmodule //검증완료



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

endmodule //검증완료



module card_value (
        input clk, rst,
        input [5-1:0] rnd,
        output [2-1:0] color,
        output [3-1:0] number
    );
        reg [2-1:0] r_color, q_color;
        reg [3-1:0] r_number, q_number;

    assign color = r_color;
    assign number = r_number;

    always @(posedge clk) begin
        if (!rst) begin
            q_color <= 2'b0;
            q_number <= 3'b0;
        end
        else
        begin
            q_color <= r_color;
            q_number <= r_number;
        end
    end

    always @(*) begin
        r_color = (rnd[4:3] %3) + 1'b1;
        r_number = (rnd[2:0] %5) + 1'b1;
    end

endmodule //검증완료


module demux (
        input clk, rst,
        input whose,
        input [5-1:0] rnd,
        output reg [5-1:0] card_value1, card_value2
    );
        
    always @(posedge clk) begin
        if (!rst) begin
            card_value1 <= 5'b0;
            card_value2 <= 5'b0;
        end
        else begin
            if (whose) card_value1 <= rnd;
            else card_value2 <= rnd;
        end
    end
endmodule //검증완료