////////////////////////////////////////////////////////////////////////////////
// Nume modul: testbench_and
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza un testbench modulele dezvoltate in laborator.
//
// Modificari:
//   01/12/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////


module testbench();

// Declaram 4 variabile interne de tip wire pentru 
// a putea reliza conexiunile intre iesirile generatorului de stimuli si intrarile 
// portii and

wire conexiune_a;
wire conexiune_b;
wire conexiune_c;
wire conexiune_d;

wire conexiune_y;

// Instantierea modulului poarta_and
// primul cuvant reprezinta numele modulului, asa cum a fost descris in fisier 
// cel de-al doilea cuvant - MUX_INST, reprezinta numele intantei curente
mux_2_1 MUX_INST( 
    .a_i(conexiune_a),  // intrarea a_i a instantei MUX_INST se conecteaza la variabila conexiune_a
    .b_i(conexiune_b),  // intrarea b_i a instantei MUX_INST se conecteaza la variabila conexiune_b
    .s_i(conexiune_c),  // intrarea s_i a instantei MUX_INST se conecteaza la variabila conexiune_c
    .y_o(conexiune_y)   // iesirea y_o a instantei MUX_INST se conecteaza la variabila conexiune_y 
);

generator_stimuli GENERATOR_INST( 
    .a_o(conexiune_a), // iesirea a_o a instantei GENERATOR_INST se conecteaza la variabila conexiune_a 
    .b_o(conexiune_b), // iesirea b_o a instantei GENERATOR_INST se conecteaza la variabila conexiune_b 
    .c_o(conexiune_c),  // iesirea c_o a instantei GENERATOR_INST se conecteaza la variabila conexiune_c
    .d_o(conexiune_d)  // iesirea d_o a instantei GENERATOR_INST se conecteaza la variabila conexiune_d  
  
);

// Instantiati codorul si conectati-l la generatorul de stimuli
wire [1:0] conexiune_iesire_codor;
wire iesire_valid;

codor CODOR_INST(
    .a_i(conexiune_a),
    .b_i(conexiune_b), 
    .c_i(conexiune_c), 
    .d_i(conexiune_d),
    .y_o(conexiune_iesire_codor),
    .valid_o(iesire_valid)
);


endmodule