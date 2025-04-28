`timescale 1ns/1ps

module tb_fsm;

    reg sys_clk;
    reg sys_rst_n;
    reg [3:0] key_pad_reg;
    wire [3:0] key_pad;
    wire [7:0] display_bi;

    assign key_pad = key_pad_reg;

    top_module uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .E(1'b0),
        .F(1'b0),
        .G(1'b0),
        .A(),
        .B(),
        .C(),
        .D(),
        .CA(), .CB(), .CC(), .CD(), .CE(), .CF(), .CG(), .DP(),
        .AN(),
        .test(key_pad)
    );

    // 時脈產生：50MHz
    initial sys_clk = 0;
    always #5 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1;
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;
    end

    // 模擬按鍵彈跳行為
    task press_key_with_bounce(input [3:0] key_value);
        begin
            // 模擬 bouncing
            key_pad_reg = key_value;
            #3 key_pad_reg = 4'hf;
            #4 key_pad_reg = key_value;
            #2 key_pad_reg = 4'hf;
            #1 key_pad_reg = key_value;

            // 保持穩定一段時間
            #50;
        end
    endtask

    initial begin
        key_pad_reg = 4'd0;
        #10;

        // 輸入 3，模擬 bouncing
        press_key_with_bounce(4'd3);

        // 按下 load 鍵（A = 4'hA）
        press_key_with_bounce(4'ha);

        // 輸入 5
        press_key_with_bounce(4'd5);

        // 再按下 load
        press_key_with_bounce(4'ha);

        // 按下 clear
        press_key_with_bounce(4'hb);

        $stop;
    end

endmodule

/*
module tb_fsm;

    reg sys_clk;
    reg sys_rst_n;
    reg [3:0] key_pad_reg;
    wire [3:0] key_pad;
    wire [7:0] display_bi;

    assign key_pad = key_pad_reg;

    top_module uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .E(1'b0),
        .F(1'b0),
        .G(1'b0),
        .A(),
        .B(),
        .C(),
        .D(),
        .CA(), .CB(), .CC(), .CD(), .CE(), .CF(), .CG(), .DP(),
        .AN(),
        .test(key_pad)
    );

    initial sys_clk = 0;
    always #5 sys_clk = ~sys_clk; // 20ns period => 50MHz

    initial begin
        sys_rst_n = 1;
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1;
    end

    initial begin
        key_pad_reg = 4'd0;
        #10;

        key_pad_reg = 4'd3;
        #5 key_pad_reg = 4'hf;
        #5 key_pad_reg = 4'hf;
        #5 key_pad_reg = 4'hf;
        #5 key_pad_reg = 4'hf;
        #5 key_pad_reg = 4'hf;
        #5 key_pad_reg = 4'hf;
        #100;

        key_pad_reg = 4'ha;
        #100;

        key_pad_reg = 4'd5;
        #100;

        key_pad_reg = 4'ha;
        #100;

        key_pad_reg = 4'hb;
        #100;

        $stop;
    end

endmodule
*/