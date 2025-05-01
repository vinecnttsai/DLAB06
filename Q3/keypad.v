module keypad(
    input sys_clk,
    input sys_rst_n,
    input E,
    input F,
    input G,
    output A,
    output B,
    output C,
    output D,
    output [3:0] locked_out
);


    parameter default_out = 4'hf;
    parameter IDLE = 0, HOLD = 1;
    parameter SCN_rate = 1000;
    parameter SCN_WIDTH = 4;
    parameter SCN_cnt = SCN_rate * SCN_WIDTH - 1;
    parameter SCN_cnt_log = $clog2(SCN_cnt + 1);
    (*mark_debug = "true", dont_touch = "true"*)reg [3:0] out;
    (*mark_debug = "true", dont_touch = "true"*)wire scn_clk;
    (*mark_debug = "true", dont_touch = "true"*)reg Q;
    (*mark_debug = "true", dont_touch = "true"*)reg Q_next;
    (*mark_debug = "true", dont_touch = "true"*)wire [SCN_cnt_log-1:0] count;

    (* keep_hierarchy = "yes" *)keypad_fq_div #(SCN_rate) keypad_clk (
        .org_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .div_n_clk(scn_clk)
    );

    keypad_shift #(4, 1) scn (
        .sys_rst_n(sys_rst_n),
        .clk(scn_clk),
        .enable(1'b1),
        .in(4'b0001),
        .init(4'b0001),
        .load(1'b0),
        .dir(1'b0),
        .out({A, B, C, D})
    );

    keypad_locker #(.SCN_cnt(SCN_cnt)) cnt_SCN (
        .clk(sys_clk),
        .org(out),
        .lock(Q),
        .cnt(count),
        .locked(locked_out)
    );

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            Q <= IDLE;
        end else begin
            Q <= Q_next;
        end
    end

    always @(*) begin
        case (Q)
            IDLE: begin
                if (out != 4'hf) begin
                    Q_next = HOLD;
                end else begin
                    Q_next = IDLE;
                end
            end
            HOLD: begin
                if (count == SCN_cnt - 1) begin
                    Q_next = IDLE;
                end else begin
                    Q_next = HOLD;
                end
            end
            default: Q_next = IDLE;
        endcase
    end
    

    always @(*) begin
        case({A, B, C, D, E, F, G})
            7'b1000100: out = 4'h1;
            7'b0100100: out = 4'h4;
            7'b0010100: out = 4'h7;
            7'b0001100: out = 4'ha;
            7'b1000010: out = 4'h2;
            7'b0100010: out = 4'h5;
            7'b0010010: out = 4'h8;
            7'b0001010: out = 4'hb;
            7'b1000001: out = 4'h3;
            7'b0100001: out = 4'h6;
            7'b0010001: out = 4'h9;
            7'b0001001: out = 4'hc;
            default: out = 4'hf;
        endcase
    end

endmodule

module keypad_fq_div #(parameter N = 2)(
    input org_clk,
    input sys_rst_n,
    output reg div_n_clk
); 
    reg [63:0] count;

always @(posedge org_clk or negedge sys_rst_n) begin

    if (!sys_rst_n) begin
        div_n_clk <= 1'b0;
    end else if (count == N - 2) begin
        div_n_clk <= 1'b1;
    end else begin
        div_n_clk <= 1'b0;
    end
end
    
always @(posedge org_clk or negedge sys_rst_n) begin
    
    if (!sys_rst_n) begin
        count <= 0;
    end else if (count == N - 1) begin
        count <= 0;
    end else begin
        count <= count + 1;
    end
end

endmodule 

module keypad_shift #(parameter N = 8, parameter SHIFT = 1) (
    input sys_rst_n,
    input clk,
    input enable,
    input [N-1:0] in,
    input [N-1:0] init,
    input load,
    input dir, // 1: right, 0: left
    output [N-1:0] out
);

    reg [N-1:0] shift;

    always @(posedge clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            shift <= init;
        end else if (!enable) begin
            shift <= shift;
        end else if (load) begin
            shift <= in;
        end else begin
            shift <= (dir) ? {shift[N-SHIFT-1:0], shift[N - 1: N - SHIFT]} : {shift[SHIFT - 1: 0], shift[N-1:SHIFT]};
        end
    end

    assign out = shift;
    
endmodule

module keypad_locker #(
    parameter SCN_cnt = 3999
)(
    input clk,
    input lock,
    input [3:0] org,
    output reg [$clog2(SCN_cnt + 1) - 1:0] cnt,
    output reg [3:0] locked
);

    always @(posedge clk) begin
        if (!lock) begin
            cnt <= 0;
        end else if (cnt == SCN_cnt - 1) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end

    always @(posedge clk) begin
        if (!lock) begin
            locked <= org;
        end
    end

endmodule
