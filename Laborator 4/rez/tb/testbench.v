////////////////////////////////////////////////////////////////////////////////
// Nume modul: testbench
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul este testbench-ul în care vor fi instanțiate restul modulelor.
//
// Modificari:
//   16/04/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module testbench ();

// Instanțierea generatorului de ceas și reset
localparam SEMIPERIOADA = 20;  // Parametru local pentru a defini semiperioada ceasului

wire       conexiune_clk             ;    // Declarăm conexiunea pentru semnalul de ceas
wire       conexiune_rst_n           ;  // Declarăm conexiunea pentru semnalul de reset 
wire       conexiune_enable          ;
wire [5:0] conexiune_desired_temp    ;
wire       conexiune_set_desired_temp;
wire [5:0] conexiune_measured_temp   ;
gen_clk_rst #(SEMIPERIOADA) GENERATOR_CLK_RST(
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);

gen_stimuli_termostat GENERATOR_STIMULI_TERMOSTAT(
    .clk_i              (conexiune_clk             ),  
    .rst_n_i            (conexiune_rst_n           ),  
    .enable_i           (conexiune_enable          ),  
    .desired_temp_o     (conexiune_desired_temp    ),  
    .set_desired_temp_o (conexiune_set_desired_temp),  
    .measured_temp_o    (conexiune_measured_temp   )
);

// Instantiati termostatul si conectati-l la generatoarele de semnal
 termostat TERMOSTAT_INST (
  .clk_i             (conexiune_clk             ),
  .rst_n_i           (conexiune_rst_n           ),
  .desired_temp_i    (conexiune_desired_temp    ),
  .set_desired_temp_i(conexiune_set_desired_temp),
  .measured_temp_i   (conexiune_measured_temp   ),
  .enable_o          (conexiune_enable          )
);   


endmodule