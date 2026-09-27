module sliding_window_3x3 #(
    parameter int image_width = 5
)(
    input clk,
    input rst,
    input pixel_valid,

    input signed [7:0] pixel_in,

    output reg window_valid,
    output reg signed [7:0] window [0:8]
);

    reg signed [7:0] line_buffer1 [0:image_width-1];
    reg signed [7:0] line_buffer2 [0:image_width-1];

    reg signed [7:0] row1_left, row1_mid, row1_right;
    reg signed [7:0] row2_left, row2_mid, row2_right;
    reg signed [7:0] row3_left, row3_mid, row3_right;

    integer column;
    integer row_count;
    integer i;

    always @(posedge clk) begin

        if (rst) begin

            column <= 0;
            row_count <= 0;
            window_valid <= 0;

            row1_left <= 0;
            row1_mid <= 0;
            row1_right <= 0;

            row2_left <= 0;
            row2_mid <= 0;
            row2_right <= 0;

            row3_left <= 0;
            row3_mid <= 0;
            row3_right <= 0;

            for (i = 0; i < image_width; i = i + 1) begin
                line_buffer1[i] <= 0;
                line_buffer2[i] <= 0;
            end

            for (i = 0; i < 9; i = i + 1)
                window[i] <= 0;

        end

        else if (pixel_valid) begin

            // Shift row 1
            row1_right <= row1_mid;
            row1_mid   <= row1_left;
            row1_left  <= line_buffer2[column];

            // Shift row 2
            row2_right <= row2_mid;
            row2_mid   <= row2_left;
            row2_left  <= line_buffer1[column];

            // Shift row 3
            row3_right <= row3_mid;
            row3_mid   <= row3_left;
            row3_left  <= pixel_in;

            // Update line buffers
            line_buffer2[column] <= line_buffer1[column];
            line_buffer1[column] <= pixel_in;

            // Generate valid 3x3 window
            if ((row_count >= 2) && (column >= 2)) begin

                window[0] <= row1_mid;
                window[1] <= row1_left;
                window[2] <= line_buffer2[column];

                window[3] <= row2_mid;
                window[4] <= row2_left;
                window[5] <= line_buffer1[column];

                window[6] <= row3_mid;
                window[7] <= row3_left;
                window[8] <= pixel_in;

                window_valid <= 1;

            end
            else begin
                window_valid <= 0;
            end

            // Move column
            if (column == image_width-1) begin

                column <= 0;

                // Move to next row
                if (row_count == image_width-1)
                    row_count <= 0;
                else
                    row_count <= row_count + 1;

            end
            else begin
                column <= column + 1;
            end

        end

        else begin
            window_valid <= 0;
        end

    end

endmodule