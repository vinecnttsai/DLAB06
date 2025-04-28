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
        forever #5 sys_clk = ~sys_clk; // 10ns period
    end

    initial begin
        // Initialize inputs
        sys_rst_n = 1;
        enable = 0;
        dir = 0;

        // Reset sequence
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;

        // Test enable
        #50;

        // Enable shifting to left
        enable = 1;
        dir = 0; // shift left

        // Run for some time
        #5000;

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
    
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            $display("Reset active - seq_shift_sliced = X");
        end else begin
            $display("At time %t: cnt = %d, seq_shift = %h, seq_shift_sliced = %h", $time, uut.m1.cnt, uut.m1.seq_shift, uut.m1.seq_shift_sliced);
        end
    end

endmodule
