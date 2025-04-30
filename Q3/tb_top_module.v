module top_module_tb;

    reg sys_clk;
    reg sys_rst_n;
    reg load_button;
    reg sum_button;
    reg clr_button;
    reg [3:0] key_pad;
    
    top_module uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .load_button(load_button),
        .sum_button(sum_button),
        .clr_button(clr_button),
        .E(),
        .F(),
        .G(),
        .A(),
        .B(),
        .C(),
        .D(),
        .CA(),
        .CB(),
        .CC(),
        .CD(),
        .CE(),
        .CF(),
        .CG(),
        .DP(),
        .AN(),
        .test(key_pad)
    );

    always begin
        #5 sys_clk = ~sys_clk;
    end

    integer k, j;
    initial begin
        // Initialize Inputs
        sys_clk = 0;
        sys_rst_n = 1;
        load_button = 0;
        sum_button = 0;
        clr_button = 0;

        // Apply Reset
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;

        for (k = 1; k < 10; k = k + 1) begin
            for (j = 1; j < 10; j = j + 1) begin
                key_pad = k;
                #10 bounce_load(4);
                key_pad = j;
                #10 bounce_load(5);
                #2 bounce_sum(5);
                #2 bounce_clr(2);
            end
        end
        #10;
        $finish;
    end

    task bounce_load(input integer bounce_times);
        integer i;
        begin
            for (i = 0; i < bounce_times; i = i + 1) begin
                load_button = 1;
                #2;
                load_button = 0;
                #2;
            end
        end
    endtask

    task bounce_sum(input integer bounce_times);
        integer i;
        begin
            for (i = 0; i < bounce_times; i = i + 1) begin
                sum_button = 1;
                #2;
                sum_button = 0;
                #2;
            end
        end
    endtask

    task bounce_clr(input integer bounce_times);
        integer i;
        begin
            for (i = 0; i < bounce_times; i = i + 1) begin
                clr_button = 1;
                #2;
                clr_button = 0;
                #2;
            end
        end
    endtask
    
endmodule
