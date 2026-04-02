////////////////////////////////////////////////////////////////////////////////
// Nume modul: testbench
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul este testbench-ul în care vor fi instanțiate restul modulelor.
//
// Modificari:
//   02/04/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////


// se poate folosi la proiect
module testbench ();

// Instanțierea generatorului de ceas și reset
localparam SEMIPERIOADA = 20;  // Parametru local pentru a defini semiperioada ceasului
localparam NUMAR_BITI_LOCAL = 4; // Parametru local pentru a defini numarul de biti

wire conexiune_clk;    // Declarăm conexiunea pentru semnalul de ceas
wire conexiune_rst_n;  // Declarăm conexiunea pentru semnalul de reset 

wire conexiune_underflow;
wire conexiune_overflow;
wire conexiune_enable;
wire conexiune_load;
wire [NUMAR_BITI_LOCAL-1:0] conexiune_data;
wire [NUMAR_BITI_LOCAL-1:0] iesire_counter;
wire conexiune_count_up;
wire conexiune_count_down;
wire buffer_overflow;


gen_clk_rst #(SEMIPERIOADA) GENERATOR_CLK_RST(
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);


// Instantiati generatorul pentru scenariul de testare
gen_scenariu_testare #(
    .NUMAR_BITI(NUMAR_BITI_LOCAL)
) SCENARIU_INST (
    .clk_i      (conexiune_clk     ),
    .rst_n_i    (conexiune_rst_n   ),
    .underflow_i(conexiune_underflow),
    .overflow_i (buffer_overflow),
    .enable_o(conexiune_enable),
    .load_o(conexiune_load),
    .data_o(conexiune_data),
    .count_up_o(conexiune_count_up),
    .count_down_o (conexiune_count_down)
);
// Instantiati numaratorul
counter #(
    .NUMAR_BITI(NUMAR_BITI_LOCAL)
) COUNTER_INST (
    .clk_i       (conexiune_clk),
    .rst_n_i     (conexiune_rst_n),
    .data_i      (conexiune_data),
    .enable_i    (conexiune_enable),
    .load_i      (conexiune_load),
    .count_up_i  (conexiune_count_up) ,
    .count_down_i(conexiune_count_down) ,

    .data_o      (iesire_counter),
    .underflow_o (conexiune_underflow),
    .overflow_o  (conexiune_overflow)

);
// Instantiati comparatorul
comparator #(
    .NUMAR_BITI(NUMAR_BITI_LOCAL)
) COMPARATOR_INST (
    .first_number_in  (iesire_counter),
    .second_number_in ('d10),
    .numbers_equal_o ()
);

shift_register SHIFT_REGISTER_INST (
    .clk_i(conexiune_clk),
    .rst_n_i(conexiune_rst_n),
    .data_i(conexiune_overflow),
    .data_o (buffer_overflow)
);
    
endmodule