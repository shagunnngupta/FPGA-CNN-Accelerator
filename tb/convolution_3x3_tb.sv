`timescale 1ns/1ps

module convolution_3x3_tb;

reg signed [7:0] pixels [0:8];
reg signed [7:0] weights [0:8];
wire signed [31:0] result;

convolution_3x3 uut(
    .pixels(pixels),
    .weights(weights),
    .result(result)
);

integer i;

initial begin
    $dumpfile("sim/convolution_3x3.vcd");
    $dumpvars(0,convolution_3x3_tb);

    for(i=0;i<9;i=i+1)
        weights[i]=1;

    pixels[0]=1;
    pixels[1]=2;
    pixels[2]=3;
    pixels[3]=6;
    pixels[4]=7;
    pixels[5]=8;
    pixels[6]=11;
    pixels[7]=12;
    pixels[8]=13;

    #10;
    $display("WINDOW 1: RESULT = %d",result);

    pixels[0]=2;
    pixels[1]=3;
    pixels[2]=4;
    pixels[3]=7;
    pixels[4]=8;
    pixels[5]=9;
    pixels[6]=12;
    pixels[7]=13;
    pixels[8]=14;

    #10;
    $display("WINDOW 2: RESULT = %d",result);

    pixels[0]=3;
    pixels[1]=4;
    pixels[2]=5;
    pixels[3]=8;
    pixels[4]=9;
    pixels[5]=10;
    pixels[6]=13;
    pixels[7]=14;
    pixels[8]=15;

    #10;
    $display("WINDOW 3: RESULT = %d",result);

    $finish;
end
endmodule