module cnn_accelerator #(
    parameter int IMAGE_WIDTH = 5,
    parameter int total_outputs = 9
)(
    input clk,
    input rst,

    input start,
    input signed [7:0] pixel_in,
    input pixel_valid,

    input signed [7:0] weights [0:8],

    output wire busy,
    output wire enable,

    output wire output_valid,
    output wire signed [7:0] quantized_out,

    output wire [31:0] output_count,
    output wire processing_done
);

    wire controller_enable;

    cnn_controller controller (
        .clk(clk),
        .rst(rst),
        .start(start),
        .processing_done(processing_done),
        .busy(busy),
        .enable(controller_enable)
    );

    assign enable = controller_enable;

    wire cnn_output_valid;

    streaming_convolution #(
        .image_width(IMAGE_WIDTH)
    ) cnn_pipeline (
        .clk(clk),
        .rst(rst),
        .pixel_valid(pixel_valid && controller_enable),
        .pixel_in(pixel_in),
        .weights(weights),
        .output_valid(cnn_output_valid),
        .quantized_out(quantized_out)
    );

    assign output_valid = cnn_output_valid;

    output_counter #(
        .total_outputs(total_outputs)
    ) counter (
        .clk(clk),
        .rst(rst),
        .output_valid(cnn_output_valid),
        .processing_done(processing_done),
        .output_count(output_count)
    );
endmodule