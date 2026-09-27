module convolution_3x3(
    input signed [7:0] pixels [0:8],
    input signed [7:0] weights [0:8],
    output signed [31:0] result
);
mac_array #(
    .num_mac(9)
) mac_engine (
    .a(pixels),
    .b(weights),
    .result(result)
);
endmodule