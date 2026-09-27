`timescale 1ns/1ps

module sliding_window_3x3_tb;

    localparam int image_width = 5;

    reg clk;
    reg rst;
    reg pixel_valid;
    reg signed [7:0] pixel_in;

    wire signed [7:0] window [0:8];
    wire window_valid;

    sliding_window_3x3 #(
        .image_width(image_width)
    ) uut (
        .clk(clk),
        .rst(rst),
        .pixel_valid(pixel_valid),
        .pixel_in(pixel_in),
        .window(window),
        .window_valid(window_valid)
    );

    // Clock
    always #5 clk = ~clk;

    // Display generated windows
    always @(posedge clk) begin
        #1;

        if (window_valid) begin
            $display(
                "WINDOW: %0d %0d %0d | %0d %0d %0d | %0d %0d %0d",
                window[0], window[1], window[2],
                window[3], window[4], window[5],
                window[6], window[7], window[8]
            );
        end
    end

    initial begin

        $dumpfile("sim/sliding_window_3x3.vcd");
        $dumpvars(0, sliding_window_3x3_tb);

        clk = 0;
        rst = 1;
        pixel_valid = 0;
        pixel_in = 0;

        // Hold reset
        #12;

        // Wait for a falling edge before starting input
        @(negedge clk);

        // Release reset and put first pixel on input
        rst = 0;
        pixel_valid = 1;
        pixel_in = 1;

        // -------------------------
        // Row 1
        // -------------------------

        @(negedge clk); pixel_in = 2;
        @(negedge clk); pixel_in = 3;
        @(negedge clk); pixel_in = 4;
        @(negedge clk); pixel_in = 5;

        // -------------------------
        // Row 2
        // -------------------------

        @(negedge clk); pixel_in = 6;
        @(negedge clk); pixel_in = 7;
        @(negedge clk); pixel_in = 8;
        @(negedge clk); pixel_in = 9;
        @(negedge clk); pixel_in = 10;

        // -------------------------
        // Row 3
        // -------------------------

        @(negedge clk); pixel_in = 11;
        @(negedge clk); pixel_in = 12;
        @(negedge clk); pixel_in = 13;
        @(negedge clk); pixel_in = 14;
        @(negedge clk); pixel_in = 15;

        // -------------------------
        // Row 4
        // -------------------------

        @(negedge clk); pixel_in = 16;
        @(negedge clk); pixel_in = 17;
        @(negedge clk); pixel_in = 18;
        @(negedge clk); pixel_in = 19;
        @(negedge clk); pixel_in = 20;

        // -------------------------
        // Row 5
        // -------------------------

        @(negedge clk); pixel_in = 21;
        @(negedge clk); pixel_in = 22;
        @(negedge clk); pixel_in = 23;
        @(negedge clk); pixel_in = 24;
        @(negedge clk); pixel_in = 25;

        // Allow final output to be observed
        #10;

        $finish;

    end

endmodule