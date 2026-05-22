module counter(
    input clk_i,
    input rst_n_i,
    input enable,
    input sens_numarare,
    output [3:0] data_o  
);

reg [3:0] data_internal;

always @(posedge clk_i or negedge rst_n_i) begin
    if(~rst_n_i) data_internal <= 0;
    else if(enable) begin
        if(sens_numarare) data_internal <= data_internal + 1;
        else data_internal <= data_internal - 1;
    end
end

assign data_o = data_internal;

endmodule