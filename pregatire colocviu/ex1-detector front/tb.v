module tb();


wire conexiune_clk;
wire conexiune_rst_n;
wire conexiune_data;
wire conexiune_data_out;

gen_clk_rst GEN_CLK_RST_INST (
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);

gen_stimuli GEN_STIMULI_INST (
    .clk(conexiune_clk),
    .rst_n(conexiune_rst_n),
    .data(conexiune_data)
);

circuit CIRCUIT_INST (
    .clk(conexiune_clk),
    .rst_n(conexiune_rst_n),
    .data(conexiune_data),
    .data_out(conexiune_data_out)
);

endmodule