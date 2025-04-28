module tb_top ();

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

    // 時脈產生器：100MHz
    initial sys_clk = 0;
    always #5 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1;
        {E, F, G} = 3'b111;
        #3 sys_rst_n = 0;
        #3 sys_rst_n = 1; // 先復位，然後釋放按鍵

        // 模擬按下 G 鍵（E=1, F=1, G=0），對應 3'b110
        #50;
        press_key(3'b110);

        // 模擬 bouncing
        #30;  bounce_key(3'b110, 5);

        // 再按一次不同鍵
        #300;
        press_key(3'b101); // 對應 3'b101

        #50;
        bounce_key(3'b101, 4);

        // 測試結束
        #1000;
        $finish;
    end

    // 任意按鍵模擬
    task press_key(input [2:0] key);
        begin
            {E, F, G} = key;
            #100;
            {E, F, G} = 3'b111; // 鬆開
        end
    endtask

    // 模擬 bouncing（多次重複快速跳動）
    task bounce_key(input [2:0] key, input integer bounce_times);
        integer i;
        begin
            for (i = 0; i < bounce_times; i = i + 1) begin
                {E, F, G} = key;
                #10;
                {E, F, G} = key + 3;
                #10;
                {E, F, G} = 3'b111;
                #10;
            end
        end
    endtask

endmodule
