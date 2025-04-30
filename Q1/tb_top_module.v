`timescale 1ns/1ps

module top_modul_tb;

    reg sys_clk;
    reg sys_rst_n;
    reg enable;
    reg dir;

    wire CA;
    wire CB;
    wire CC;
    wire CD;
    wire CE;
    wire CF;
    wire CG;
    wire DP;
    wire [7:0] AN;

    top_module uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .enable(enable),
        .dir(dir),
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

    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk;
    end

    initial begin
        sys_rst_n = 1;
        enable = 0;
        dir = 0;

        // Reset sequence
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;

        // Disable shifting
        enable = 0;
        dir = 0; // shift left

        // Enable shifting to left
        #1000 enable = 1;

        // Run for some time
        #4000;

        // Change direction to right
        dir = 1; // shift right

        // Run for more time
        #5000;

        // Disable shifting
        enable = 0;

        // Finish simulation
        #500;
        $stop;
    end

endmodule
