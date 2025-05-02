`timescale 1ns/1ps

module tb_top_module ();

    reg sys_clk;
    reg sys_rst_n;
    reg E, F, G;
    wire A, B, C, D;
    wire CA, CB, CC, CD, CE, CF, CG, DP;
    wire [7:0] AN;

    top_module uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .E(E),
        .F(F),
        .G(G),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
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

    initial sys_clk = 0;
    always #5 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1;
        {E, F, G} = 3'b000;
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;

        #100 press_key(3'b001);

        #30 bounce_key(3'b001, 5);

        #300 press_key(3'b010);

        #50 bounce_key(3'b010, 4);

        #1000;
        $finish;
    end

    task press_key(input [2:0] key);
        begin
            #2 // delay
            {E, F, G} = key;
            #100;
            {E, F, G} = 3'b000;
            #2 // delay
        end
    endtask

    task bounce_key(input [2:0] key, input integer bounce_times);
        integer i;
        begin
            for (i = 0; i < bounce_times; i = i + 1) begin
                {E, F, G} = key;
                #10;
                {E, F, G} = key + 3;
                #10;
                {E, F, G} = 3'b000;
                #10;
            end
        end
    endtask

endmodule
