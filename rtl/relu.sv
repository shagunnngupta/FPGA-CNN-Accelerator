module relu(
    input signed [31:0] data_in,
    output signed [31:0] data_out
);
assign data_out = (data_in>0) ? data_in : 32'sd0;
endmodule