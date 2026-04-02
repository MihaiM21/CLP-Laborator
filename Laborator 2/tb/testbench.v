////////////////////////////////////////////////////////////////////////////////
// Nume modul: testbench
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul este testbench-ul în care vor fi instanțiate restul modulelor.
//
// Modificari:
//   18/03/2023 | Stefan Gheorghe | Varianta initiala
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

// Instanțierea generatorului de stimuli
localparam BITI_DATE = 6; // Parametru local pentru a defini numărul de biți de date

wire [BITI_DATE-1:0] conexiune_date; // Declarăm conexiunea pentru semnalul de date

generator_stimuli #(BITI_DATE) GENERATOR_DATE(
    .stimuli_o(conexiune_date)
);

// Instanțierea bistabilului de tip D
wire iesire_bistabil;
wire iesire_bistabil_negata;

dff BISTABIL_INST(
    .clk_i(conexiune_clk), 
    .d_i(conexiune_date[2]),  // Selectăm bitul 4 din conexiunea de date ca intrare în bistabil 
    .q_o(iesire_bistabil), 
    .not_q_o (iesire_bistabil_negata)
);

// Instanțiați latch-ul de tip D. Conectați-l la aceleași surse de semnal ca și bistabilul D.
wire iesire_latch;
wire iesire_latch_negata;

d_latch LATCH_INST(
    .clk_i(conexiune_clk),
    .d_i(conexiune_date[2]),
    .q_o(iesire_latch),
    .not_q_o(iesire_latch_negata)

);

// Instanțiați bistabilul de tip D cu reset. 

dff_with_rst BISTABIL_RESET_INST(
    .clk_i(conexiune_clk),
    .rst_async_n_i(conexiune_rst_n),
    .rst_sync_n_i(conexiune_date[4]),
    .d_i(conexiune_date[2]),
    .q_o(),
    .not_q_o()
);

// Intrarea de reset asincronă conectați-o la ieșirea corespunzătoare a generatorului de clock și reset.
// Intrarea de reset sincronă conectați-o la bitul 4 al ieșirii generatorului de date.


// Instanțiați registrul implementat. 
// Lățimea acestuia trebuie să fie egală cu parametrul local BITI_DATE.
register_param_width #(.REGISTER_WIDTH(BITI_DATE)) REGISTRU_INST(
    .clk_i(conexiune_clk),
    .rst_async_n_i(conexiune_rst_n),
    .data_i(conexiune_date),
    .data_o()
);

    
endmodule