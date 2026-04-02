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
wire conexiune_dff_q;     // Declarăm conexiunea ieșirea bistabilului
wire conexiune_dff_not_q; // Declarăm conexiunea ieșirea negată a bistabilului

dff DFF_INST(
    .clk_i   (conexiune_clk      ), 
    .d_i     (conexiune_date[4]  ),  // Selectăm bitul 4 din conexiunea de date ca intrare în bistabil 
    .q_o     (conexiune_dff_q    ), 
    .not_q_o (conexiune_dff_not_q)

);

// Instanțiați latch-ul de tip D. Conectați-l la aceleași surse de semnal ca și bistabilul D.
wire latch_d_o;
wire latch_d_n_o;

d_latch D_LATCH_INST(
    .clk_i	(conexiune_clk),  // Intrarea de ceas a modulului
    .d_i  	(conexiune_date[4]),  // Intrarea de date a modulului
    .q_o  	(latch_d_o),  // Ieșirea Q a modulului, declarată de tip reg
    .not_q_o(latch_d_n_o)    // Ieșirea ~Q a modulului, declarată de tip reg
);
// Instanțiați bistabilul de tip D cu reset.
wire dff_rst_q;
wire dff_rst_q_n;

dff_with_rst DFF_RST_INST(
    .clk_i         (conexiune_clk),  // Intrarea de ceas a modulului
    .rst_async_n_i (conexiune_rst_n),  // Intrarea de reset asincronă a modulului, activă in 0
    .rst_sync_n_i  (1'b1),  // Intrarea de reset sincronă a modulului, activă in 0
    .d_i           (conexiune_date[4]),  // Intrarea de date a modulului
    .q_o           (dff_rst_q),  // Ieșirea Q a modulului, declarată de tip reg
    .not_q_o       (dff_rst_q_n)   // Ieșirea ~Q a modulului
); 
// Intrarea de reset asincronă conectați-o la ieșirea corespunzătoare a generatorului de clock și reset.
// Intrarea de reset sincronă conectați-o la bitul 4 al ieșirii generatorului de date.

// Instanțiați registrul implementat. Lățimea acestuia trebuie să fie egală cu parametrul local BITI_DATE.
register_param_width REGISTER_PARAM_INST(
    localparam BITI_DATE = 4
)(
    input                        clk_i             ,  // Intrarea de ceas a modulului
    input                        rst_async_n_i     ,  // Intrarea de reset asincronă a modulului, activă in 0
    input  [REGISTER_WIDTH-1:0]  data_i            ,  // Intrarea de date a modulului
    output [REGISTER_WIDTH-1:0]  data_o               // Ieșirea de date a modulului
);
endmodule