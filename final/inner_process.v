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
        if (finish) begin
            count <= 8'b0;
        end
    end
    
    always @(posedge en) begin
        if (finish) begin
                count <= 8'b0;
            end
            else begin 
                count <= count + {7'b0, en};
            end
    end

endmodule



module rand_gen (
        input clk, rst,
        input en,
        output wire [5-1:0] rnd
    );
        reg [5-1:0] rand_q, nxt_rand_q;
        reg [5-1:0] buffer_q, nxt_buffer_q;
        reg en_update;

    always @(posedge clk) begin
        
        if (!rst) begin
            rand_q <= 5'b10100;
            buffer_q <= 5'd0;
        end
        else begin
            rand_q <= nxt_rand_q;
            buffer_q <= nxt_buffer_q;
        end
    end
    assign rnd = (en) ? nxt_rand_q : buffer_q;
    always @(*) begin
        nxt_rand_q = rand_q << 1;
        nxt_rand_q[0] = rand_q[2] ^ rand_q[4];
        if (en) nxt_buffer_q = nxt_rand_q;
        else nxt_buffer_q = buffer_q;
    end
endmodule //검증완료



module card_value (
        input clk, rst,
        input [5-1:0] rnd,
        output reg [2-1:0] color,
        output reg [3-1:0] number
    );

    always @(posedge clk) begin
        if (!rst) begin
            color <= 2'b0;
            number <= 3'b0;
        end
        else begin
            case (rnd[5-1:3])
            2'b00: color <= 2'b01;
            2'b01: color <= 2'b10;
            2'b10: color <= 2'b11;
            2'b11: color <= 2'b01;
            endcase
            case (rnd[3-1:0])
            3'b000: number <= 3'b001;
            3'b001: number <= 3'b010;
            3'b010: number <= 3'b011;
            3'b011: number <= 3'b100;
            3'b100: number <= 3'b101;

            3'b101: number <= 3'b001;
            3'b110: number <= 3'b010;
            3'b111: number <= 3'b011;
            endcase
        end
    end
endmodule //검증완료


module demux (
        input clk, rst,
        input whose,
        input [5-1:0] rnd,
        output reg [5-1:0] card_value1, card_value2
    );
        
    always @(whose) 
    begin
        if (!rst) begin
            card_value1 = 5'b0;
            card_value2 = 5'b0;
        end
        else begin
            if (whose) begin
                card_value1 = rnd;
            end
            else begin
                card_value2 = rnd;
            end
        end    
    end
endmodule //검증완료