module de10_lite_top (
    input wire CLOCK_50,

    input wire [1:0] KEY,

    output wire [9:0] LEDR
);

    // =================================================
    // Clock
    // =================================================

    wire clk;
    assign clk = CLOCK_50;


    // =================================================
    // Reset and Start
    // =================================================

    wire rst;
    wire start;

    assign rst   = ~KEY[0];
    assign start = ~KEY[1];


    // =================================================
    // Test Image
    // =================================================

    reg signed [7:0] image [0:24];

    initial begin

        image[0]  = 1;
        image[1]  = 2;
        image[2]  = 3;
        image[3]  = 4;
        image[4]  = 5;

        image[5]  = 6;
        image[6]  = 7;
        image[7]  = 8;
        image[8]  = 9;
        image[9]  = 10;

        image[10] = 11;
        image[11] = 12;
        image[12] = 13;
        image[13] = 14;
        image[14] = 15;

        image[15] = 16;
        image[16] = 17;
        image[17] = 18;
        image[18] = 19;
        image[19] = 20;

        image[20] = 21;
        image[21] = 22;
        image[22] = 23;
        image[23] = 24;
        image[24] = 25;

    end


    // =================================================
    // CNN Accelerator Signals
    // =================================================

    wire busy;
    wire enable;

    wire output_valid;
    wire signed [7:0] quantized_out;

    wire [31:0] output_count;
    wire processing_done;


    // =================================================
    // Pixel Counter
    // =================================================

    reg [5:0] pixel_index;

    always @(posedge clk) begin

        if (rst) begin
            pixel_index <= 0;
        end

        else if (!busy) begin
            pixel_index <= 0;
        end

        else if (pixel_index < 25) begin
            pixel_index <= pixel_index + 1;
        end

    end


    // =================================================
    // Pixel Generator
    // =================================================

    wire pixel_valid;
    wire signed [7:0] pixel_in;

    assign pixel_valid = busy && (pixel_index < 25);

    assign pixel_in = image[pixel_index];


    // =================================================
    // Convolution Weights
    // =================================================

    wire signed [7:0] weights [0:8];

    assign weights[0] = 1;
    assign weights[1] = 1;
    assign weights[2] = 1;

    assign weights[3] = 1;
    assign weights[4] = 1;
    assign weights[5] = 1;

    assign weights[6] = 1;
    assign weights[7] = 1;
    assign weights[8] = 1;


    // =================================================
    // CNN Accelerator
    // =================================================

    cnn_accelerator #(
        .IMAGE_WIDTH(5),
        .TOTAL_OUTPUTS(9)
    ) accelerator (

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


    // =================================================
    // LEDs
    // =================================================

    assign LEDR[0] = busy;
    assign LEDR[1] = output_valid;
    assign LEDR[2] = processing_done;

    assign LEDR[9:3] = quantized_out[6:0];

endmodule