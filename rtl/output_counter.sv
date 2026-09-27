module output_counter #(
    parameter int total_outputs = 9
)(
    input clk,
    input rst,
    input output_valid,

    output reg processing_done,
    output reg [31:0] output_count
);

    always @(posedge clk) begin

        if (rst) begin

            output_count <= 0;
            processing_done <= 0;

        end

        else if (!processing_done && output_valid) begin

            if (output_count == total_outputs - 1) begin

                output_count <= output_count + 1;
                processing_done <= 1;

            end

            else begin

                output_count <= output_count + 1;
            end

        end

    end

endmodule