module streaming_convolution #(
    parameter int image_width = 5
)(
    input clk, rst, pixel_valid,
    input signed [7:0] pixel_in,
    input signed [7:0] weights [0:8],
    output wire output_valid,
    output wire signed [7:0] quantized_out
);
wire signed [7:0] window [0:8];
wire window_valid;
sliding_window_3x3 #(
    .image_width(image_width)
) window_generator (
    .clk(clk),
    .rst(rst),
    .pixel_valid(pixel_valid),
    .pixel_in(pixel_in),
    .window(window),
    .window_valid(window_valid)
);

wire signed [31:0] raw_conv_result;

convolution_3x3 uut(
    .weights(weights),
    .result(raw_conv_result),
    .pixels(window)
);

wire signed [31:0] relu_result;

relu dut(
    .data_in(raw_conv_result),
    .data_out(relu_result)
);

quantizer #(
    .output_width(8),
    .shift(2)
) fut(
    .data_in(relu_result),
    .data_out(quantized_out)
);

assign output_valid=window_valid;
endmodule