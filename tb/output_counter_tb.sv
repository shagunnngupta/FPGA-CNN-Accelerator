`timescale 1ns/1ps

module output_counter_tb;
    reg clk;
    reg rst;
    reg output_valid;
    wire processing_done;
    wire [31:0] output_count;
    output_counter #(
        .total_outputs(9)
    ) uut (
        .clk(clk),
        .rst(rst),
        .output_valid(output_valid),
        .processing_done(processing_done),
        .output_count(output_count)
    );
    always #5 clk = ~clk;
    integer i;
    initial begin
        $dumpfile("sim/output_counter.vcd");
        $dumpvars(0, output_counter_tb);
        clk = 0;
        rst = 1;
        output_valid = 0;
        #12;
        rst = 0;
        for (i = 0; i < 9; i = i + 1) begin
            @(negedge clk);
            output_valid = 1;
            @(posedge clk);
            #1;
            $display(
                "Output %0d: count = %0d, done = %0d",
                i + 1,
                output_count,
                processing_done
            );
            @(negedge clk);
            output_valid = 0;
        end
        #10;
        $finish;
    end
endmodule