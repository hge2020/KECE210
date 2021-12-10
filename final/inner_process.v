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

reg [5-1:0] rand_q, nxt_rand_q;
reg en_update;
assign rnd = rand_q;

always @(posedge clk) begin
    if(!rst) rand_q <= 5'b11100;
    else begin
        if (en_update) begin
            rand_q <= nxt_rand_q;
        end
        else begin
            rand_q <= rand_q;
        end
    end
    if (en) en_update <= 1'b1;
    else en_update <= 1'b0;
end

always @(*) begin
    nxt_rand_q = rand_q << 1;
    nxt_rand_q[0] = rand_q[2] ^ rand_q[4];
end

endmodule

module pseudo_random (
    input clk, rst,
    input en,
    output reg [5-1:0] rnd
);

    reg [8-1:0] cnt;

    always @(posedge clk) begin
    if(!rst) begin
        rnd <= 5'b0;
        cnt <= 8'b0;
    end
    else begin
        cnt <= cnt + (en);
        case(cnt)
        8'b00000000 : rnd <= 5'b00110;
        8'b00000001 : rnd <= 5'b00001;
        8'b00000010 : rnd <= 5'b01001;
        8'b00000011 : rnd <= 5'b00111;
        8'b00000100 : rnd <= 5'b10110;
        8'b00000101 : rnd <= 5'b11100;
        8'b00000110 : rnd <= 5'b01110;
        8'b00000111 : rnd <= 5'b11011;
        8'b00001000 : rnd <= 5'b00001;
        8'b00001001 : rnd <= 5'b10001;
        8'b00001010 : rnd <= 5'b00111;
        8'b00001011 : rnd <= 5'b01110;
        8'b00001100 : rnd <= 5'b00111;
        8'b00001101 : rnd <= 5'b00001;
        8'b00001110 : rnd <= 5'b00001;
        8'b00001111 : rnd <= 5'b10001;
        8'b00010000 : rnd <= 5'b11001;
        8'b00010001 : rnd <= 5'b11101;
        8'b00010010 : rnd <= 5'b01000;
        8'b00010011 : rnd <= 5'b00101;
        8'b00010100 : rnd <= 5'b10110;
        8'b00010101 : rnd <= 5'b00011;
        8'b00010110 : rnd <= 5'b01000;
        8'b00010111 : rnd <= 5'b11111;
        8'b00011000 : rnd <= 5'b11001;
        8'b00011001 : rnd <= 5'b11011;
        8'b00011010 : rnd <= 5'b00010;
        8'b00011011 : rnd <= 5'b10001;
        8'b00011100 : rnd <= 5'b01110;
        8'b00011101 : rnd <= 5'b00000;
        8'b00011110 : rnd <= 5'b11110;
        8'b00011111 : rnd <= 5'b10001;
        8'b00100000 : rnd <= 5'b00011;
        8'b00100001 : rnd <= 5'b11011;
        8'b00100010 : rnd <= 5'b00011;
        8'b00100011 : rnd <= 5'b01000;
        8'b00100100 : rnd <= 5'b10011;
        8'b00100101 : rnd <= 5'b10011;
        8'b00100110 : rnd <= 5'b11011;
        8'b00100111 : rnd <= 5'b11010;
        8'b00101000 : rnd <= 5'b00011;
        8'b00101001 : rnd <= 5'b11011;
        8'b00101010 : rnd <= 5'b00001;
        8'b00101011 : rnd <= 5'b10100;
        8'b00101100 : rnd <= 5'b00010;
        8'b00101101 : rnd <= 5'b10010;
        8'b00101110 : rnd <= 5'b01010;
        8'b00101111 : rnd <= 5'b10110;
        8'b00110000 : rnd <= 5'b11000;
        8'b00110001 : rnd <= 5'b10101;
        8'b00110010 : rnd <= 5'b10100;
        8'b00110011 : rnd <= 5'b00001;
        8'b00110100 : rnd <= 5'b11010;
        8'b00110101 : rnd <= 5'b01010;
        8'b00110110 : rnd <= 5'b10100;
        8'b00110111 : rnd <= 5'b11101;
        8'b00111000 : rnd <= 5'b01111;
        8'b00111001 : rnd <= 5'b01000;
        8'b00111010 : rnd <= 5'b01010;
        8'b00111011 : rnd <= 5'b11101;
        8'b00111100 : rnd <= 5'b10101;
        8'b00111101 : rnd <= 5'b10100;
        8'b00111110 : rnd <= 5'b11111;
        8'b00111111 : rnd <= 5'b11101;
        8'b01000000 : rnd <= 5'b11001;
        8'b01000001 : rnd <= 5'b11000;
        8'b01000010 : rnd <= 5'b10001;
        8'b01000011 : rnd <= 5'b01100;
        8'b01000100 : rnd <= 5'b11001;
        8'b01000101 : rnd <= 5'b00000;
        8'b01000110 : rnd <= 5'b01010;
        8'b01000111 : rnd <= 5'b01001;
        8'b01001000 : rnd <= 5'b01111;
        8'b01001001 : rnd <= 5'b00010;
        8'b01001010 : rnd <= 5'b10011;
        8'b01001011 : rnd <= 5'b00101;
        8'b01001100 : rnd <= 5'b00100;
        8'b01001101 : rnd <= 5'b11111;
        8'b01001110 : rnd <= 5'b00000;
        8'b01001111 : rnd <= 5'b11010;
        8'b01010000 : rnd <= 5'b10100;
        8'b01010001 : rnd <= 5'b10101;
        8'b01010010 : rnd <= 5'b00100;
        8'b01010011 : rnd <= 5'b10101;
        8'b01010100 : rnd <= 5'b11110;
        8'b01010101 : rnd <= 5'b01010;
        8'b01010110 : rnd <= 5'b10110;
        8'b01010111 : rnd <= 5'b00110;
        8'b01011000 : rnd <= 5'b11010;
        8'b01011001 : rnd <= 5'b10001;
        8'b01011010 : rnd <= 5'b11011;
        8'b01011011 : rnd <= 5'b10011;
        8'b01011100 : rnd <= 5'b10111;
        8'b01011101 : rnd <= 5'b00010;
        8'b01011110 : rnd <= 5'b01101;
        8'b01011111 : rnd <= 5'b10101;
        8'b01100000 : rnd <= 5'b00101;
        8'b01100001 : rnd <= 5'b01011;
        8'b01100010 : rnd <= 5'b10010;
        8'b01100011 : rnd <= 5'b11001;
        8'b01100100 : rnd <= 5'b11110;
        8'b01100101 : rnd <= 5'b01000;
        8'b01100110 : rnd <= 5'b00010;
        8'b01100111 : rnd <= 5'b11110;
        8'b01101000 : rnd <= 5'b10110;
        8'b01101001 : rnd <= 5'b10111;
        8'b01101010 : rnd <= 5'b11111;
        8'b01101011 : rnd <= 5'b01101;
        8'b01101100 : rnd <= 5'b11000;
        8'b01101101 : rnd <= 5'b10100;
        8'b01101110 : rnd <= 5'b11100;
        8'b01101111 : rnd <= 5'b00110;
        8'b01110000 : rnd <= 5'b01011;
        8'b01110001 : rnd <= 5'b00100;
        8'b01110010 : rnd <= 5'b10000;
        8'b01110011 : rnd <= 5'b11010;
        8'b01110100 : rnd <= 5'b10001;
        8'b01110101 : rnd <= 5'b00011;
        8'b01110110 : rnd <= 5'b01010;
        8'b01110111 : rnd <= 5'b01010;
        8'b01111000 : rnd <= 5'b01110;
        8'b01111001 : rnd <= 5'b00000;
        8'b01111010 : rnd <= 5'b01010;
        8'b01111011 : rnd <= 5'b11001;
        8'b01111100 : rnd <= 5'b00110;
        8'b01111101 : rnd <= 5'b10111;
        8'b01111110 : rnd <= 5'b11010;
        8'b01111111 : rnd <= 5'b01110;
        8'b10000000 : rnd <= 5'b10011;
        8'b10000001 : rnd <= 5'b10011;
        8'b10000010 : rnd <= 5'b01000;
        8'b10000011 : rnd <= 5'b11100;
        8'b10000100 : rnd <= 5'b10001;
        8'b10000101 : rnd <= 5'b10011;
        8'b10000110 : rnd <= 5'b01010;
        8'b10000111 : rnd <= 5'b01110;
        8'b10001000 : rnd <= 5'b01010;
        8'b10001001 : rnd <= 5'b00001;
        8'b10001010 : rnd <= 5'b11110;
        8'b10001011 : rnd <= 5'b01110;
        8'b10001100 : rnd <= 5'b00111;
        8'b10001101 : rnd <= 5'b11111;
        8'b10001110 : rnd <= 5'b10100;
        8'b10001111 : rnd <= 5'b01110;
        8'b10010000 : rnd <= 5'b00001;
        8'b10010001 : rnd <= 5'b11111;
        8'b10010010 : rnd <= 5'b01111;
        8'b10010011 : rnd <= 5'b01100;
        8'b10010100 : rnd <= 5'b10111;
        8'b10010101 : rnd <= 5'b11000;
        8'b10010110 : rnd <= 5'b10110;
        8'b10010111 : rnd <= 5'b01110;
        8'b10011000 : rnd <= 5'b10101;
        8'b10011001 : rnd <= 5'b11100;
        8'b10011010 : rnd <= 5'b11111;
        8'b10011011 : rnd <= 5'b11110;
        8'b10011100 : rnd <= 5'b01011;
        8'b10011101 : rnd <= 5'b11110;
        8'b10011110 : rnd <= 5'b10101;
        8'b10011111 : rnd <= 5'b11100;
        8'b10100000 : rnd <= 5'b11101;
        8'b10100001 : rnd <= 5'b00001;
        8'b10100010 : rnd <= 5'b00010;
        8'b10100011 : rnd <= 5'b11100;
        8'b10100100 : rnd <= 5'b01110;
        8'b10100101 : rnd <= 5'b11001;
        8'b10100110 : rnd <= 5'b10110;
        8'b10100111 : rnd <= 5'b11001;
        8'b10101000 : rnd <= 5'b01111;
        8'b10101001 : rnd <= 5'b00101;
        8'b10101010 : rnd <= 5'b00001;
        8'b10101011 : rnd <= 5'b01001;
        8'b10101100 : rnd <= 5'b11010;
        8'b10101101 : rnd <= 5'b01010;
        8'b10101110 : rnd <= 5'b10000;
        8'b10101111 : rnd <= 5'b01000;
        8'b10110000 : rnd <= 5'b10011;
        8'b10110001 : rnd <= 5'b10010;
        8'b10110010 : rnd <= 5'b01100;
        8'b10110011 : rnd <= 5'b01110;
        8'b10110100 : rnd <= 5'b11110;
        8'b10110101 : rnd <= 5'b00011;
        8'b10110110 : rnd <= 5'b01111;
        8'b10110111 : rnd <= 5'b01000;
        8'b10111000 : rnd <= 5'b11101;
        8'b10111001 : rnd <= 5'b01010;
        8'b10111010 : rnd <= 5'b00000;
        8'b10111011 : rnd <= 5'b10011;
        8'b10111100 : rnd <= 5'b01110;
        8'b10111101 : rnd <= 5'b01010;
        8'b10111110 : rnd <= 5'b00100;
        8'b10111111 : rnd <= 5'b00110;
        8'b11000000 : rnd <= 5'b10001;
        8'b11000001 : rnd <= 5'b10101;
        8'b11000010 : rnd <= 5'b10111;
        8'b11000011 : rnd <= 5'b00110;
        8'b11000100 : rnd <= 5'b11110;
        8'b11000101 : rnd <= 5'b01111;
        8'b11000110 : rnd <= 5'b01011;
        8'b11000111 : rnd <= 5'b00110;
        8'b11001000 : rnd <= 5'b10111;
        8'b11001001 : rnd <= 5'b00110;
        8'b11001010 : rnd <= 5'b00101;
        8'b11001011 : rnd <= 5'b00110;
        8'b11001100 : rnd <= 5'b10011;
        8'b11001101 : rnd <= 5'b00010;
        8'b11001110 : rnd <= 5'b11111;
        8'b11001111 : rnd <= 5'b01101;
        8'b11010000 : rnd <= 5'b00001;
        8'b11010001 : rnd <= 5'b11100;
        8'b11010010 : rnd <= 5'b00010;
        8'b11010011 : rnd <= 5'b10001;
        8'b11010100 : rnd <= 5'b11111;
        8'b11010101 : rnd <= 5'b10010;
        8'b11010110 : rnd <= 5'b01001;
        8'b11010111 : rnd <= 5'b00111;
        8'b11011000 : rnd <= 5'b10001;
        8'b11011001 : rnd <= 5'b11000;
        8'b11011010 : rnd <= 5'b01110;
        8'b11011011 : rnd <= 5'b10011;
        8'b11011100 : rnd <= 5'b11001;
        8'b11011101 : rnd <= 5'b11001;
        8'b11011110 : rnd <= 5'b11010;
        8'b11011111 : rnd <= 5'b10100;
        8'b11100000 : rnd <= 5'b01110;
        8'b11100001 : rnd <= 5'b11000;
        8'b11100010 : rnd <= 5'b11100;
        8'b11100011 : rnd <= 5'b00010;
        8'b11100100 : rnd <= 5'b10000;
        8'b11100101 : rnd <= 5'b10111;
        8'b11100110 : rnd <= 5'b01011;
        8'b11100111 : rnd <= 5'b00101;
        8'b11101000 : rnd <= 5'b01011;
        8'b11101001 : rnd <= 5'b11010;
        8'b11101010 : rnd <= 5'b01100;
        8'b11101011 : rnd <= 5'b11000;
        8'b11101100 : rnd <= 5'b11010;
        8'b11101101 : rnd <= 5'b10110;
        8'b11101110 : rnd <= 5'b01110;
        8'b11101111 : rnd <= 5'b01001;
        8'b11110000 : rnd <= 5'b00010;
        8'b11110001 : rnd <= 5'b10100;
        8'b11110010 : rnd <= 5'b10100;
        8'b11110011 : rnd <= 5'b00001;
        8'b11110100 : rnd <= 5'b00010;
        8'b11110101 : rnd <= 5'b00011;
        8'b11110110 : rnd <= 5'b01111;
        8'b11110111 : rnd <= 5'b00110;
        8'b11111000 : rnd <= 5'b10000;
        8'b11111001 : rnd <= 5'b10100;
        8'b11111010 : rnd <= 5'b00101;
        8'b11111011 : rnd <= 5'b00011;
        8'b11111100 : rnd <= 5'b10101;
        8'b11111101 : rnd <= 5'b10101;
        8'b11111110 : rnd <= 5'b10111;
        8'b11111111 : rnd <= 5'b00011;
        endcase
    end
end

endmodule

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
        
    always @(*) 
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