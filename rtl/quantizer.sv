module quantizer #(
    parameter int output_width=8,
    parameter int shift=0
)(
    input signed [31:0] data_in,
    output signed [output_width-1:0] data_out
);

wire signed [31:0] shifted_data;

assign shifted_data = data_in >>> shift;
assign data_out = shifted_data[output_width-1:0];

endmodule