module seven_segment (
    input clk, rst,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos
);
    reg [3-1:0] count_q, count_d;

always @(posedge clk) begin
    if(~rst) begin
        data_pos <= 8'b0;
        data_out <= 7'b0;
        count_q <= 3'b0;
    end
    else begin
        count_q <= count_d;
        case(count_q)
        3'b000: begin
            data_pos <= 8'b1111_1110;
            data_out <= 7'100_1111;
        end
        3'b001: begin
            data_pos <= 8'b1111_1101;
            data_out <= 7'b0;
        end
        3'b010: begin
            data_pos <= 8'b1111_1011;
            data_out <= 7'b0;
        end
        3'b011: begin
            data_pos <= 8'b1111_0111;
            data_out <= 7'b0;
        end
        3'b100: begin
            data_pos <= 8'b1110_1111;
            data_out <= 7'b0;
        end
        3'b101: begin
            data_pos <= 8'b1101_1111;
            data_out <= 7'b0;
        end
        3'b110: begin
            data_pos <= 8'b1011_1111;
            data_out <= 7'b0;
        end
        3'b111: begin
            data_pos <= 8'b0111_1111;
            data_out <= 7'b000_0110;
        end
        endcase
    end
end

always @(*) begin
    count_d = count_q + 3'b1;
end

endmodule