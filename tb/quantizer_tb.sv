`timescale 1ns/1ps

module quantizer_tb;

reg signed [31:0] data_in;
wire signed [7:0] data_out;

quantizer #(
    .output_width(8),
    .shift(2)
) uut(
    .data_in(data_in), .data_out(data_out)
);

initial begin
    $dumpfile("sim/quantizer.vcd");
    $dumpvars(0,quantizer_tb);

    data_in = 100;
    #10;
    $display("Input: %d, Quantized Output: %d",data_in,data_out);

    data_in = 200;
    #10;
    $display("Input: %d, Quantized Output: %d",data_in,data_out);

    data_in = -100;
    #10;
    $display("Input: %d, Quantized Output: %d",data_in,data_out);

    data_in = 63;
    #10;
    $display("Input: %d, Quantized Output: %d",data_in,data_out);

    $finish;
end
endmodule