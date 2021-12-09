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
            en <= 1'b0;
            whose <= 1'b0;
        end
        else begin
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
    end
endmodule


module counter (
        input clk, rst,
        input en, finish,
        output reg [8-1:0] count
    );

    always @(posedge clk) begin
        if (!rst) begin
            count <= 8'b0;
        end
        else begin
            //count <= count + {7'b0, en};
            if (finish) begin
                count <= 8'b0;
            end
            else begin 
                count <= count + {7'b0, en};
            end
        end
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

endmodule //검증완료



module card_value (
        input clk, rst,
        input [5-1:0] rnd,
        output reg [2-1:0] color,
        output reg [3-1:0] number
    );
        // reg [2-1:0] r_color, q_color;
        // reg [3-1:0] r_number, q_number;

    // assign color = r_color;
    // assign number = r_number;

    always @(posedge clk) begin
        if (!rst) begin
            color <= 2'b0;
            number <= 3'b0;
        end
        else begin
            case (rnd[4:3])
            2'b00: color <= 2'b01;
            2'b01: color <= 2'b10;
            2'b10: color <= 2'b11;
            2'b11: color <= 2'b01;
            endcase
            case (rnd[2:0])
            3'b000: color <= 3'b001;
            3'b001: color <= 3'b010;
            3'b010: color <= 3'b011;
            3'b011: color <= 3'b100;
            3'b100: color <= 3'b101;

            3'b101: color <= 3'b001;
            3'b110: color <= 3'b010;
            3'b111: color <= 3'b011;
            endcase
        end
    end

    // always @(*) begin // ???
    //     r_color = (rnd[4:3] %3) + 1'b1;
    //     r_number = (rnd[2:0] %5) + 1'b1;
    // end


    // always @(*) begin
    //     case (rnd[4:3])
    //     2'b00: r_color <= 2'b01;
    //     2'b01: r_color <= 2'b10;
    //     2'b10: r_color <= 2'b11;
    //     2'b11: r_color <= 2'b01;
    //     endcase
    //     case (rnd[2:0])
    //     3'b000: r_color <= 3'b001;
    //     3'b001: r_color <= 3'b010;
    //     3'b010: r_color <= 3'b011;
    //     3'b011: r_color <= 3'b100;
    //     3'b100: r_color <= 3'b101;

    //     3'b101: r_color <= 3'b001;
    //     3'b110: r_color <= 3'b010;
    //     3'b111: r_color <= 3'b011;
    //     endcase
    // end

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