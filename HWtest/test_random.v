module tb_random(clk, l0, l1, l2, l3, l4, l5, l6, l7);

input clk;
output l0, l1, l2, l3, l4, l5, l6, l7;
random test(clk, {l7, l6, l5, l4, l3, l2, l1, l0});

endmodule