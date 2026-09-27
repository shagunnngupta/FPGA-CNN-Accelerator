`timescale 1ns/1ps

module cnn_controller_tb;
    reg clk;
    reg rst;
    reg start;
    reg processing_done;
    wire busy;
    wire enable;
    cnn_controller uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .processing_done(processing_done),
        .busy(busy),
        .enable(enable)
    );
    always #5 clk = ~clk;
    initial begin
        $dumpfile("sim/cnn_controller.vcd");
        $dumpvars(0, cnn_controller_tb);
        clk = 0;
        rst = 1;
        start = 0;
        processing_done = 0;
        #12;
        rst = 0;
        #3;
        start = 1;
        @(posedge clk);
        #1;
        $display("After START: busy = %0d, enable = %0d",
                 busy, enable);
        start = 0;
        repeat(3) @(posedge clk);
        processing_done = 1;
        @(posedge clk);
        #1;
        $display("After DONE: busy = %0d, enable = %0d",
                 busy, enable);
        processing_done = 0;
        #10;
        $finish;
    end
endmodule