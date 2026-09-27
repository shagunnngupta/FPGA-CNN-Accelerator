module cnn_controller(
    input clk, rst, start, processing_done,
    output reg busy, enable
);

always @ (posedge clk) begin
    if(rst) begin
        busy<=0;
        enable<=0;
    end
    else begin
        if(start && !busy) begin
            busy<=1;
            enable<=1;
        end
        else if(processing_done) begin
            busy<=0;
            enable<=0;
        end
    end
end
endmodule