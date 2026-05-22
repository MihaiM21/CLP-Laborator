module gen_stimuli (
    input clk,
    input rst_n,
    output reg enable,
    output reg sens_numarare
);

initial begin
    sens_numarare <= 0;
    enable <= 0;
    //astept sa se termine reset-ul
    @(posedge rst_n);
    repeat(10)@(posedge clk);
    enable <= 1;
    sens_numarare <= 1;
    repeat(5)@(posedge clk);
    sens_numarare <= 0;
    repeat(3)@(posedge clk);
    $stop;
end

endmodule