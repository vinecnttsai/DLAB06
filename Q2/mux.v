module mux #(parameter N = 4, WIDTH = 8) (
    input  [WIDTH*N-1:0] data_in,
    input [WIDTH-1:0] default_in,
    input  [$clog2(N+1)-1:0] sel,
    output [WIDTH-1:0] out
);

assign out = (sel < N) ? data_in[sel*WIDTH +: WIDTH] : default_in;

endmodule