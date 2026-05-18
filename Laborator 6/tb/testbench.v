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

wire conexiune_prg_done;  // Declarăm conexiunea pentru semnalul de program_execution_done 

gen_clk_rst #(SEMIPERIOADA) GENERATOR_CLK_RST(
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);


// Instantiati procesorul
cpu CPU_INST(
    .clk_i                    (conexiune_clk      ),
    .rst_n_i                  (conexiune_rst_n    ),
    .program_execution_done_o (conexiune_prg_done )
);

// Preincarcati memoria de instructiuni a procesorului cu programul din laborator


// Folosind un bloc "initial" initializati memoria folosind fisierul data.memh
initial begin
    @(negedge conexiune_rst_n);
    $readmemb("program.memb", CPU_INST.INSTR_MEM_INST.mem);
    @(posedge conexiune_rst_n);
    @(posedge conexiune_prg_done);
    repeat(10) @(posedge conexiune_clk);
    $stop;
end


endmodule