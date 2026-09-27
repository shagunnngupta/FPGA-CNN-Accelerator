`timescale 1ns/1ps

module cnn_accelerator_tb;

    localparam int IMAGE_WIDTH = 5;
    localparam int total_outputs = 9;

    reg clk;
    reg rst;
    reg start;
    reg pixel_valid;

    reg signed [7:0] pixel_in;
    reg signed [7:0] weights [0:8];

    wire busy;
    wire enable;

    wire output_valid;
    wire signed [7:0] quantized_out;

    wire [31:0] output_count;
    wire processing_done;

    cnn_accelerator #(
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .total_outputs(total_outputs)
    ) uut (
        .clk(clk),
        .rst(rst),

        .start(start),
        .pixel_in(pixel_in),
        .pixel_valid(pixel_valid),

        .weights(weights),

        .busy(busy),
        .enable(enable),

        .output_valid(output_valid),
        .quantized_out(quantized_out),

        .output_count(output_count),
        .processing_done(processing_done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        #1;

        if (output_valid) begin

            $display(
                "OUTPUT %0d: quantized = %0d",
                output_count,
                quantized_out
            );

        end

        if (processing_done) begin

            $display(
                "PROCESSING DONE: total outputs = %0d",
                output_count
            );

        end

    end

    initial begin

        $dumpfile("sim/cnn_accelerator.vcd");
        $dumpvars(0, cnn_accelerator_tb);

        clk = 0;
        rst = 1;
        start = 0;
        pixel_valid = 0;
        pixel_in = 0;

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

        @(negedge clk);

        rst = 0;

        start = 1;

        @(negedge clk);

        start = 0;
        pixel_valid = 1;

        pixel_in = 1;

        @(negedge clk); pixel_in = 2;
        @(negedge clk); pixel_in = 3;
        @(negedge clk); pixel_in = 4;
        @(negedge clk); pixel_in = 5;

        @(negedge clk); pixel_in = 6;
        @(negedge clk); pixel_in = 7;
        @(negedge clk); pixel_in = 8;
        @(negedge clk); pixel_in = 9;
        @(negedge clk); pixel_in = 10;

        @(negedge clk); pixel_in = 11;
        @(negedge clk); pixel_in = 12;
        @(negedge clk); pixel_in = 13;
        @(negedge clk); pixel_in = 14;
        @(negedge clk); pixel_in = 15;

        @(negedge clk); pixel_in = 16;
        @(negedge clk); pixel_in = 17;
        @(negedge clk); pixel_in = 18;
        @(negedge clk); pixel_in = 19;
        @(negedge clk); pixel_in = 20;

        @(negedge clk); pixel_in = 21;
        @(negedge clk); pixel_in = 22;
        @(negedge clk); pixel_in = 23;
        @(negedge clk); pixel_in = 24;
        @(negedge clk); pixel_in = 25;

        @(negedge clk);
        pixel_valid = 0;
        pixel_in = 0;

        #20;
        $finish;
    end
endmodule