module full_c_LED (
    input clk, rst,
    input [2-1:0] c_value1, c_value2,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b //LED위치 다시보기
);
    reg [6-1:0] out;

always @(posedge clk) begin
    if (!rst) begin
        out <= 6'b0;
    end
    else begin
        case({c_value1[1], c_value1[0]})
        2'b01: out[6-1:3] <= 3'b100;
        2'b10: out[6-1:3] <= 3'b010;
        2'b11: out[6-1:3] <= 3'b001;
        default: out[6-1:3] <= 3'b000;
        endcase

        case({c_value2[1], c_value2[0]})
        2'b01: out[3-1:0] <= 3'b100;
        2'b10: out[3-1:0] <= 3'b010;
        2'b11: out[3-1:0] <= 3'b001;
        default: out[3-1:0] <= 3'b000;
        endcase
    end
end

assign {led_1_r, led_1_g, led_1_b, led_2_r, led_2_g, led_2_b} = out;

endmodule



module display (
    input clk, rst,
    input [3-1:0] c_value,
    output reg [7-1:0] seg
);

always @(*) begin
    // if(!rst) begin
    //     seg = 7'b111_1111;
    // end
    // else begin
        
    // end
    case(c_value)
        3'b001: seg = 7'b000_0110; //1
        3'b010: seg = 7'b101_1011; //2
        3'b011: seg = 7'b100_1111; //3
        3'b100: seg = 7'b110_0110; //4
        3'b101: seg = 7'b110_1101; //5
        default: seg = 7'b000_0000; //void
    endcase
end

endmodule



module seven_segment (
    input clk, rst,
    input [7-1:0] seg1, seg2,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos
);
    reg [3-1:0] count_q, count_d;

always @(posedge clk) begin
    if(!rst) begin
        count_q <= 3'b0;
    end
    else begin
        count_q <= count_d;
    end
end

always @(*) begin
    if(!rst) begin
        data_pos = 8'b0;
        data_out = 7'b0;
        count_d = 3'b0;
    end
    else begin
        count_d = count_q + 3'b1;

        case(count_q)
        3'b000: begin
            data_pos = 8'b1111_1110;
            data_out = seg1;
        end
        3'b001: begin
            data_pos = 8'b1111_1101;
            data_out = 7'b0;
        end
        3'b010: begin
            data_pos = 8'b1111_1011;
            data_out = 7'b0;
        end
        3'b011: begin
            data_pos = 8'b1111_0111;
            data_out = 7'b0;
        end
        3'b100: begin
            data_pos = 8'b1110_1111;
            data_out = 7'b0;
        end
        3'b101: begin
            data_pos = 8'b1101_1111;
            data_out = 7'b0;
        end
        3'b110: begin
            data_pos = 8'b1011_1111;
            data_out = 7'b0;
        end
        3'b111: begin
            data_pos = 8'b0111_1111;
            data_out = seg2;
        end
        endcase
    end

end

endmodule

module LED (
    input clk, rst,
    input [2-1:0] LED_sig,
    output reg [8-1:0] led
);

    always @(posedge clk) begin
        if (!rst) begin
            led <= 8'b0;
        end
        else begin
            case (LED_sig)
            2'b01: begin
                led <= 8'b1111_0000;
            end
            2'b10: begin
                led <= 8'b0000_1111;
            end
            default begin
                led <= 8'b0;
            end
            endcase
        end
    end
endmodule