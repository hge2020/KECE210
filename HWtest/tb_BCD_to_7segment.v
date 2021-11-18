module tb_BCD_to_7segment;

    input D9, D8, D7, D6, D5, D4, D3, D2, D1, D0;
    output A, B, C, D, F, G;

    BCD_to_7segment BCD7(D9, D8, D7, D6, D5, D4, D3, D2, D1, D0,A,B,C,D,E,F,G);

endmodule
