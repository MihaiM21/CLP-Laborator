////////////////////////////////////////////////////////////////////////////////
// Nume modul: testbench
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul este testbench-ul în care vor fi instanțiate restul modulelor.
//
// Modificari:
//    08/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module testbench ();

// Instanțierea generatorului de ceas și reset
localparam SEMIPERIOADA = 20;  // Parametru local pentru a defini semiperioada ceasului

wire conexiune_clk;    // Declarăm conexiunea pentru semnalul de ceas
wire conexiune_rst_n;  // Declarăm conexiunea pentru semnalul de reset 

gen_clk_rst #(SEMIPERIOADA) GENERATOR_CLK_RST(
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);

// Parametrii pentru instantierea memoriei dar si a generatorului de stimuli depind
// de continutul fisierului data.memh
wire [31:0]                 conexiune_wr_data;
wire [3:0]                  conexiune_address;
wire                        conexiune_we     ;
wire                  		conexiune_ce     ;
wire [31:0]                 conexiune_rd_data;


// Instantiati generatorul de stimuli
gen_stimuli_mem GENERATOR_STIMULUI(
    .clk_i    (conexiune_clk),
    .wr_data_i(conexiune_wr_data),
    .address_i(conexiune_address),
    .we       (conexiune_we),
    .ce       (conexiune_ce),
    .rd_data_o(conexiune_rd_data) 
);

// Instantiati memoria 
mem_1rw MEM_INST(
    .clk_i    (conexiune_clk) ,
    .wr_data_i(conexiune_wr_data) ,
    .address_i(conexiune_address) ,
    .we_i     (conexiune_we)   ,
    .ce_i     (conexiune_ce)   ,
    .rd_data_o(conexiune_rd_data) 
);
    
endmodule