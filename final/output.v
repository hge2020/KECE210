module full_c_LED (
    input clk, rst,
    input [2-1:0] c_value1, c_value2,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b, //LED위치 다시보기
);
    reg [6-1:0] out;

always @(posedge clk) begin
    if (!rst) begin
        out <= 6'b0;
    end
    else begin
        case({c_value1[1], {c_value1[0], c_value2[1], {c_value2[0]})
        4'b01_00: out <= 100_000;
        4'b10_00: out <= 010_000;
        4'b11_00: out <= 001_000;

        4'b00_01: out <= 000_100;
        4'b00_10: out <= 000_010;
        4'b00_11: out <= 000_001;
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
    reg [7-1:0] temp;

always @(posedge clk) begin
    if(~rst) begin
        seg <= 7'b0;
        temp <= 7'b0;
    end
end

always @(posedge clk) begin
    case(c_value)
        3'b000: temp <= 7'b0110000; //1
        3'b001: temp <= 7'b1101101; //2
        3'b010: temp <= 7'b1111001; //3
        3'b011: temp <= 7'b0110011; //4
        3'b100: temp <= 7'b1011011; //5
        default: temp <= 7'b0110000; //0
    endcase
    seg <= temp;
end

endmodule

module seven_segment (
    input clk, rst,
    input [7-1:0] seg1, seg2,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos
);
    reg [3-1:0] count = 3'b0;

always @(posedge clk) begin
    if(~rst) begin
        data_pos <= 8'b0;
        data_out <= 7'b0;
    end
    else begin
        count <= count+1'b1;
        case(count)
        3'b000: begin
            data_pos <= 0000_0001;
            data_out <= seg1;
        end
        3'b111: begin
            data_pos <= 1000_0000;
            data_out <= seg2;
        end
        default: begin
            data_pos <= 8'b0;
            data_out <= 7'b0;
        end
        endcase
    end
end

endmodule



module LCD (
    ports
);
    
endmodule