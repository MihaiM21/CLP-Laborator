module tb();

wire clk;
wire rst_n;
wire data;
wire secv_gasita;

gen_clk_rst GEN_CLK_RST_INST (
    .clk_o   (clk),
    .rst_n_o (rst_n)
);

gen_stimuli GEN_STIMULI_DUT (
    .clk(clk),
    .rst_n(rst_n),
    .data(data)
);

fsm FSM_DUT (
    .clk_i(clk),
    .rst_n_i(rst_n),
    .data(data),
    .secv_gasita(secv_gasita)
);

endmodule