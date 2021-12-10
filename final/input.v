// module keypad_scan( //리셋없음
//     input clk, rst,
//     input [12-1:0] keypad_in,
//     output reg [4-1:0] scan_out,
//     output reg valid
// ); //버튼 받아서 몇번이 눌렸는지 4bit으로 내보냄.

//     reg temp;

// initial begin
//     valid <= 1'b0;
//     temp <= 1'b0;
// end 

// always @(posedge clk or negedge rst) begin
//     if ( ~rst ) begin
//         valid <= 1'b0;
//         temp <= 1'b0;
//         scan_out <= 12'b0;
//     end
//     else begin
//         if (keypad_in && ~temp) begin
//             case(keypad_in)
//             12'b0000_0000_0001: scan_out<= 4'b0001; //1
//             12'b0000_0000_0100: scan_out<= 4'b0011; //3
//             12'b0000_0100_0000: scan_out<= 4'b0111; //7
//             12'b0001_0000_0000: scan_out<= 4'b1001; //9
//             default: scan_out<= 4'b0000; //0
//             endcase
//             valid <= 1'b1;
//             temp <= 1'b1;
//         end
//         else if (keypad_in && temp) begin
//             scan_out <= 4'b0;
//             valid <= 1'b0;
//         end
//         else temp <= 1'b0;
//     end
// end

// endmodule



module keypad_scan( //리셋없음
    input clk, rst,
    input [12-1:0] keypad_in,
    output reg [4-1:0] scan_out,
); //버튼 받아서 몇번이 눌렸는지 4bit으로 내보냄.

    reg temp;

always @(posedge clk) begin
    if (!rst) begin
        scan_out <= 4'b0;
    end
    else begin
            case(keypad_in)
            12'b0000_0000_0001: scan_out<= 4'b0001; //1
            12'b0000_0000_0100: scan_out<= 4'b0011; //3
            12'b0000_0100_0000: scan_out<= 4'b0111; //7
            12'b0001_0000_0000: scan_out<= 4'b1001; //9
            default: scan_out<= 4'b0000; //0
            endcase
        end
    end
end

endmodule