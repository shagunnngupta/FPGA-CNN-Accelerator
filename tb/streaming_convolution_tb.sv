`timescale 1ns/1ps

module streaming_convolution_tb;

localparam int image_width = 5;
reg clk, rst, pixel_valid;
reg signed [7:0] pixel_in;
reg signed [7:0] weights [0:8];
wire output_valid;
wire signed [7:0] quantized_out;

streaming_convolution  #(
    .image_width(image_width)
) uut(
    .clk(clk), .rst(rst), .pixel_valid(pixel_valid),
    .pixel_in(pixel_in), .weights(weights),
    .output_valid(output_valid), .quantized_out(quantized_out)
);

always #5 clk=~clk;

always @(posedge clk) begin
    #1;
    if(output_valid) begin
        $display("Result: %d", quantized_out);
    end
end

initial begin
    $dumpfile("sim/streaming_convolution.vcd");
    $dumpvars(0,streaming_convolution_tb);

    clk=0;
    rst=1;
    pixel_in=0;
    pixel_valid=0;

    weights[0] = 1;
    weights[1] = 1;
    weights[2] = 1;
    weights[3] = 1;
    weights[4] = 1;
    weights[5] = 1;
    weights[6] = 1;
    weights[7] = 1;
    weights[8] = 1;

    #12;
    @(negedge clk) 
    rst=0; pixel_valid=1; pixel_in=1;
    @(negedge clk) pixel_in = 2;
    @(negedge clk) pixel_in = 3;
    @(negedge clk) pixel_in = 4;
    @(negedge clk) pixel_in = 5;
    @(negedge clk) pixel_in = 6;
    @(negedge clk) pixel_in = 7;
    @(negedge clk) pixel_in = 8;
    @(negedge clk) pixel_in = 9;
    @(negedge clk) pixel_in = 10;
    @(negedge clk) pixel_in = 11;
    @(negedge clk) pixel_in = 12;
    @(negedge clk) pixel_in = 13;
    @(negedge clk) pixel_in = 14;
    @(negedge clk) pixel_in = 15;
    @(negedge clk) pixel_in = 16;
    @(negedge clk) pixel_in = 17;
    @(negedge clk) pixel_in = 18;
    @(negedge clk) pixel_in = 19;
    @(negedge clk) pixel_in = 20;
    @(negedge clk) pixel_in = 21;
    @(negedge clk) pixel_in = 22;
    @(negedge clk) pixel_in = 23;
    @(negedge clk) pixel_in = 24;
    @(negedge clk) pixel_in = 25;
    #10;
    $finish;
end
endmodule