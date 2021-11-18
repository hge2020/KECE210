module tb_BCD_to_7segment;

    reg D3, D2, D1, D0;
    wire A, B, C, D, F, G;

    BCD_to_7segment BCD7(D3,D2,D1,D0,A,B,C,D,E,F,G);

    initial begin
        #10 {D3, D2, D1, D0} <= 4'b0000;
        #10 {D3, D2, D1, D0} <= 4'b0001;
        #10 {D3, D2, D1, D0} <= 4'b0010;
        #10 {D3, D2, D1, D0} <= 4'b0011;
        #10 {D3, D2, D1, D0} <= 4'b0100;
        #10 {D3, D2, D1, D0} <= 4'b0101;
        #10 {D3, D2, D1, D0} <= 4'b0110;
        #10 {D3, D2, D1, D0} <= 4'b0111;
        #10 {D3, D2, D1, D0} <= 4'b1000;
        #10 {D3, D2, D1, D0} <= 4'b1001;
    end
endmodule
