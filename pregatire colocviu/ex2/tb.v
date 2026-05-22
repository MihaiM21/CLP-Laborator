module tb();

wire clk;
wire rst_n;
wire enable;
wire sens_numarare;
wire [3:0] data_o;

gen_clk_rst GEN_CLK_RST_INST (
    .clk_o   (clk),
    .rst_n_o (rst_n)
);
gen_stimuli GEN_STIMULI_INST (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .sens_numarare(sens_numarare)
);
counter COUNTER_INST (
    .clk_i(clk),
    .rst_n_i(rst_n),
    .enable(enable),
    .sens_numarare(sens_numarare),
    .data_o(data_o)
);


endmodule