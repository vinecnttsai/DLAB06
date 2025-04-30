module top_module (
    input sys_clk,
    input sys_rst_n,
    input load_button,
    input sum_button,
    input clr_button,
    input E,
    input F,
    input G,
    output A,
    output B,
    output C,
    output D,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP,
    output [7:0] AN
    //output [3:0] test // for Simulation
);
    reg [7:0] display_bi;
    wire [7:0] display_dec;
    reg [7:0] augend;
    reg [7:0] addend;
    wire [7:0] sum;
    wire cout;
    parameter [3:0] load_val = 4'ha;
    parameter [3:0] clr_val = 4'hb;
    parameter [3:0] noise_val = 4'hf;
    parameter [7:0] idle_val = 8'h00;
    //FSM
    parameter [2:0] ADD1 = 0,
                    ADD2 = 1,
                    LOAD = 2,
                    SUM = 3,
                    CLEAR = 4;
    // debug
    (* mark_debug = "true", dont_touch = "true" *)wire [3:0] key_pad;
    (* mark_debug = "true", dont_touch = "true" *)reg [2:0] Q;
    (* mark_debug = "true", dont_touch = "true" *)reg [2:0] Q_next;

    keypad uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .E(E),
        .F(F),
        .G(G),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .locked_out(key_pad)
    );
    // assign key_pad = test // for Simulation

    wire [7:0] display_dec_no_zero; // removing leading zero
    assign display_dec_no_zero = (display_dec[7:0] > 8'h09) ? display_dec[7:0] : {4'hf, display_dec[3:0]};

    (* keep_hierarchy = "yes" *)marquee #(.N(32)) uut2 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .enable(1'b0),
        .dir(1'b0),
        .seq({{6{4'hf}}, display_dec_no_zero}),
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

(* keep_hierarchy = "yes" *) b2d_converter #(2) uut3 (
    .in(display_bi),
    .out(display_dec)
);

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        Q <= ADD1;
    end else begin
        Q <= Q_next;
    end
end
       
always @(*) begin
        case (Q)
            ADD1: begin
                if (clr_button) begin
                    Q_next <= CLEAR;
                end else if (load_button && augend != 8'h00) begin
                    Q_next <= ADD2;
                end else begin
                    Q_next <= ADD1;
                end
            end
            ADD2: begin
                if (clr_button) begin
                    Q_next <= CLEAR;
                end else if (load_button && addend != 8'h00) begin
                    Q_next <= LOAD;
                end else begin
                    Q_next <= ADD2;
                end
            end
            LOAD: begin
                if (clr_button) begin
                    Q_next <= CLEAR;
                end else if (sum_button) begin
                    Q_next <= SUM;
                end else begin
                    Q_next <= LOAD;
                end
            end
            SUM: begin
                if (clr_button) begin
                    Q_next <= CLEAR;
                end else begin
                    Q_next <= SUM;
                end
            end
            CLEAR: begin
                if (clr_button || load_button ||  sum_button) begin
                    Q_next <= CLEAR;
                end else begin
                    Q_next <= ADD1;
                end
            end
            default: Q_next <= ADD1;
        endcase
    end

    always @(*) begin
        case (Q)
            ADD1: begin
                display_bi = augend;
            end
            ADD2: begin
                display_bi = addend;
            end
            LOAD: begin
                display_bi = idle_val;
            end
            SUM: begin
                display_bi = sum;
            end
            CLEAR: begin
                display_bi = idle_val;
            end
            default: display_bi = idle_val;
        endcase
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            augend <= 8'h00;
        end else if (Q == ADD1 && key_pad != 4'hf) begin
            augend <= {4'h0, key_pad};
        end else if (Q == CLEAR) begin
            augend <= 8'h00;
        end
    end


    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            addend <= 8'h00;
        end else if (Q == ADD2 && key_pad != 4'hf) begin
            addend <= {4'h0, key_pad};
        end else if (Q == CLEAR) begin
            addend <= 8'h00;
        end
    end

    assign {cout, sum} = augend + addend;

endmodule
