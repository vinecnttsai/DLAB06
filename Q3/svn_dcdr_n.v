module svn_dcdr_n (
    input [3:0] in,
    input clk,
    input sys_rst_n,
    output CA, CB, CC, CD, CE, CF, CG,
    output DP,
    output [7:0] AN
);

svn_dcdr svn1 (
    .in(in),
    .CA(CA),
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG),
    .DP(DP)
);

shift_reg #(8, 1) display_shift (
    .sys_rst_n(sys_rst_n),
    .clk(clk),
    .enable(1'b1),
    .in(8'b1111_1110),
    .init(8'b1111_1110),
    .load(1'b0),
    .dir(1'b1),
    .out(AN)
);

endmodule