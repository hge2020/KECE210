module keypad_scan(
    input clk, rst
    input [11:0] Keypad_in,
    output [11:0] Scan_out,
    output valid
);

    always @(posedge clk) begin
        Scan_out <= Keypad_in;
        valid <= 1'b1;
    end

endmodule

module display (
    input clk, rst, valid,
    input [11:0] Scan_data,
    output reg [56-1:0] seg,
    output reg out_en
);

    reg [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,
    reg [11:0] r8; // Scan data 저장
    reg [2:0] r9; // 써야 할 레지스터 번호

assign seg = {seg8, seg7, seg6, seg5, seg4, seg3, seg2, seg1}; //이게 아마... 

endmodule



module regi (
    input clk, rst, en,
    input [6:0] in,
    output [6:0] out
);

    reg [6:0] temp;

    always @(posedge clk, rst) begin
        if (rst) begin
            out<= 7'b000_0000;
        end
        else begin
            temp <= in;
        end
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