`timescale 1ns/1ps

module mac_array_tb;

localparam num_mac=9;
reg signed [7:0] a [0:num_mac-1];
reg signed [7:0] b [0:num_mac-1];
wire signed [31:0] result;
wire signed [7:0] a0 = a[0];
wire signed [7:0] a1 = a[1];
wire signed [7:0] a2 = a[2];
wire signed [7:0] a3 = a[3];
wire signed [7:0] a4 = a[4];
wire signed [7:0] a5 = a[5];
wire signed [7:0] a6 = a[6];
wire signed [7:0] a7 = a[7];
wire signed [7:0] a8 = a[8];

wire signed [7:0] b0 = b[0];
wire signed [7:0] b1 = b[1];
wire signed [7:0] b2 = b[2];
wire signed [7:0] b3 = b[3];
wire signed [7:0] b4 = b[4];
wire signed [7:0] b5 = b[5];
wire signed [7:0] b6 = b[6];
wire signed [7:0] b7 = b[7];
wire signed [7:0] b8 = b[8];
mac_array #(
    .num_mac(num_mac)
) uut(
    .a(a),
    .b(b),
    .result(result)
);

integer i;

initial begin 
    $dumpfile("sim/mac_array.vcd");
    $dumpvars(0,mac_array_tb);

    a[0]=1;
    a[1]=2;
    a[2]=3;
    a[3]=4;
    a[4]=5;
    a[5]=6;
    a[6]=7;
    a[7]=8;
    a[8]=9;
    for (i=0;i<num_mac;i=i+1)
        b[i]=1;
    #10;
    $display("TEST 1: %d", result);

    for (i=0;i<num_mac;i=i+1) begin
        a[i]=2;
        b[i]=2;
    end
    #10;
    $display("TEST 2: %d", result);

    a[0]=-1;
    a[1]=-2;
    a[2]=-3;
    a[3]=1;
    a[4]=2;
    a[5]=3;
    a[6]=1;
    a[7]=1;
    a[8]=1;
    for(i=0;i<num_mac;i=i+1)
        b[i]=2;
    #10;
    $display("TEST 3: %d", result);
    $finish;
end
endmodule