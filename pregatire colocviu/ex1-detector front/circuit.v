module  circuit (
    input clk,
    input rst_n,
    input data,
    output data_out
);
    
reg bistabil;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        bistabil <= 0;
    else
        bistabil <= data;
end

assign data_out = ~bistabil & data;

endmodule