module stepmotor(
    input rst, clk,
    output reg [4-1:0] stepperpins
);
    parameter stepper_divider = 50; //every 1us
    reg [32-1:0] count;
    reg [3-1:0] step

    always @ (posedge clk) begin
        if(count >= stepper_divider + 1) begin
            step <= step + 1'b1;
            count <= 1'b0;
        end
        else begin
            count <= count + 1'b1;
        end
    end

    always @ (step) begin
        case(step)
        0: stepperpins <= 4'b1000;
        1: stepperpins <= 4'b1100;
        2: stepperpins <= 4'b0100;
        3: stepperpins <= 4'b0110;
        4: stepperpins <= 4'b0010;
        5: stepperpins <= 4'b0011;
        6: stepperpins <= 4'b0001;
        7: stepperpins <= 4'b1001;
        default: stepperpins <= 4'b1000;
        endcase
    end
endmodule