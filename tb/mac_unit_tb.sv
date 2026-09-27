`timescale 1ns/1ps
module mac_unit_tb;
reg clk,rst;
reg signed [7:0] a,b;
reg signed [31:0] accumulator;
wire signed [31:0] result;

mac_unit uut(.clk(clk), .rst(rst), .a(a), .b(b), .accumulator(accumulator), .result(result));

always #5 clk = ~clk;
initial begin
$dumpfile("sim/mac_unit.vcd");
$dumpvars(0,mac_unit_tb);

clk=0;
rst=1;
a=0;
b=0;
accumulator=0;

#12;
rst=0;

a=8'sd5; b=8'sd3; accumulator=32'sd10;
@(posedge clk);
#1;
$display("Test 1: %d x %d + %d = %d", a, b, accumulator, result);

a=-8'sd5; b=8'sd3; accumulator=32'sd10;
@(posedge clk);
#1;
$display("Test 2: %d x %d + %d = %d", a, b, accumulator, result);

a=8'sd10; b=-8'sd4; accumulator=32'sd50;
@(posedge clk);
#1;
$display("Test 3: %d x %d + %d = %d", a, b, accumulator, result);

$finish;
end
endmodule