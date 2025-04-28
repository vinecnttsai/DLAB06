module top_module(
    input sys_clk,
    input sys_rst_n,
    input enable,
    input dir,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP,
    output [7:0] AN
);

    parameter N = 40;
    reg [N-1:0] ID = 40'h113511270f;
    
    marquee #(.N(N)) m1 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .enable(enable),
        .dir(dir),
        .seq(ID),
        .CA(CA),
        .CB(CB),
        .CC(CC),
        .CD(CD),
        .CE(CE),
        .CF(CF),
        .CG(CG),
        .DP(DP),
        .AN(AN)
    );

endmodule