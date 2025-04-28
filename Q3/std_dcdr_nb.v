module std_dcdr_nb #(parameter N = 4) (
    input [$clog2(N)-1:0] in,
    output reg [N-1:0] out
);

always @(*) begin
    out = {N{1'b0}};
    out[in] = 1'b1;
end

endmodule
