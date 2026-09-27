`timescale 1ns/1ps

module relu_tb;
reg signed [31:0] data_in;
wire signed [31:0] data_out;

relu uut(
    .data_in(data_in), .data_out(data_out)
);

initial begin
    $dumpfile("sim/relu.vcd");
    $dumpvars(0,relu_tb);

    data_in=32'sd25;
    #10;
    $display("Input: %d, Output: %d",data_in,data_out);

    data_in=-32'sd10;
    #10;
    $display("Input: %d, Output: %d",data_in,data_out);

    data_in=32'sd0;
    #10;
    $display("Input: %d, Output: %d",data_in,data_out);

    data_in=-32'sd73;
    #10;
    $display("Input: %d, Output: %d",data_in,data_out);

    data_in=32'sd100;
    #10;
    $display("Input: %d, Output: %d",data_in,data_out);

    $finish;
end
endmodule   