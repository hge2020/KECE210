	module keypad_scan(
    input clk, rst
    input [11:0] Keypad_in,
    output reg [11:0] Scan_out,
    output reg valid
);

    assign valid <= 1b'0;
    always @(posedge clk) begin
        if (Keypad_in)begin
            case (valid)
                1'b0 : begin
                        Scan_out <= Keypad_in;
                        valid <= 1'b1;
                end
                1'b1 : Scan_out <= 0;
            endcase
        end
    end

endmodule

module display (
    input clk, rst, valid,
    input [11:0] Scan_data,
    output reg [56-1:0] seg,
    output reg Out_en
);

reg [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,
reg [11:0] r8; // Scan data 저장
reg [2:0] r9; // 써야 할 레지스터 번호

assign Out_en = 1'b0;
assign r8 = Scan_data;

if (r8 = 12'b1000_0000_0000) r9 = r9 + 1'b1; //#, r9값 증가
else if(r8 = 12'b0100_0000_0000) Out_en = 1'b1;//*, out_en 생성
else begin
    case(r9)
        3'b000 : seg1 <= r8; //r0
        3'b001 : seg2 <= r8; //r1
        3'b010 : seg3 <= r8; //r2
        3'b011 : seg4 <= r8; //r3

        3'b100 : seg5 <= r8; //r4
        3'b101 : seg6 <= r8; //r5
        3'b110 : seg7 <= r8; //r6
        3'b111 : seg8 <= r8; //r7
    endcase
end

assign seg = {seg8, seg7, seg6, seg5, seg4, seg3, seg2, seg1}; //이게 아마... 각 레지스터에 값정리하는거

endmodule


module regi (
    input clk, rst, en,
    input [6:0] in,
    output [6:0] out
);

    reg [6:0] temp;
    always @(posedge clk, rst) begin
        if (rst) out<= 7'b000_0000;
        else temp <= in;
    end
    assign out = temp;
        
endmodule

module rigister_file(
    input clk, rst, en,
    input [56-1:0] in,
    output [56-1:0] out
);
regi r0(clk, rst, en, in[6:0], out[6:0]);
regi r1(clk, rst, en, in[13:7], out[13:7]);
regi r2(clk, rst, en in[20:14], out[20:14]);
regi r3(clk, rst, en, in[27:21], out[27:21]);
regi r4(clk, rst, en, in[34:28], out[34:28]);
regi r5(clk, rst, en, in[41:35], out[41:35]);
regi r6(clk, rst, en, in[48:42], out[48:42]);
regi r7(clk, rst, en, in[55:49], out[55:49]);
    
endmodule

module segment_controller (
    input clk, rst,
    input [56-1:0] seg,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos // this port means 'data_en' port in ppt.
);
    
endmodule
