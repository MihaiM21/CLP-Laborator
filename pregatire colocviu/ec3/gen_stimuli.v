module gen_stimuli (
    input clk,
    input rst_n,
    output reg data
);

initial begin
    data <= 0;
    //astept reset
    @(posedge rst_n);
    // asteptam 5 tacte
    repeat(2)@(posedge clk);
    data <= 1;
    repeat(3)@(posedge clk);
    data <= 0;
    @(posedge clk);
    data <= 1;
    repeat(5)@(posedge clk);
    $stop;
end

endmodule