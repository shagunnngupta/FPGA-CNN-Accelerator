module mac_array #(
    parameter int num_mac = 9
)(
    input signed [7:0] a [0:num_mac-1],
    input signed [7:0] b [0:num_mac-1],
    output reg signed [31:0] result
);
reg signed [15:0] product [0:num_mac-1];
integer i;
always @ (*) begin
   for (i=0;i<num_mac;i=i+1) begin
    product[i]=a[i]*b[i];
   end
   result=32'd0;
   for (i=0;i<num_mac;i=i+1) begin
    result=result+product[i];
   end
end
endmodule 