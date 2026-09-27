module mac_unit(
    input clk,
    input rst,
    input signed [7:0] a,
    input signed [7:0] b,
    input signed [31:0] accumulator,
    output reg signed [31:0] result
);
wire signed [15:0] product;
assign product = a * b;
always @(posedge clk) begin
    if (rst)
        result <= 32'd0;
    else
        result <= accumulator + product;
end
endmodule