`timescale 1ns/1ps

module de10_lite_top_tb;

    reg CLOCK_50;
    reg [1:0] KEY;

    wire [9:0] LEDR;

    de10_lite_top uut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .LEDR(LEDR)
    );

    // 50 MHz equivalent clock
    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin

        $dumpfile("sim/de10_lite_top.vcd");
        $dumpvars(0, de10_lite_top_tb);

        CLOCK_50 = 0;

        // Both buttons released
        KEY = 2'b11;

        // Reset
        KEY[0] = 0;

        #50;

        // Release reset
        KEY[0] = 1;

        // Press START
        KEY[1] = 0;

        #20;

        // Release START
        KEY[1] = 1;

        // Allow accelerator to process
        #1000;

        $display("--------------------------------");
        $display("FINAL OUTPUT COUNT = %0d",
                 uut.output_count);
        $display("PROCESSING DONE = %0d",
                 uut.processing_done);
        $display("--------------------------------");

        $finish;

    end

endmodule