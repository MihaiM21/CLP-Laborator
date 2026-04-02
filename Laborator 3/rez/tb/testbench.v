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

module testbench ();

// Instanțierea generatorului de ceas și reset
localparam SEMIPERIOADA = 20;  // Parametru local pentru a defini semiperioada ceasului

wire conexiune_clk;    // Declarăm conexiunea pentru semnalul de ceas
wire conexiune_rst_n;  // Declarăm conexiunea pentru semnalul de reset 

gen_clk_rst #(SEMIPERIOADA) GENERATOR_CLK_RST(
    .clk_o   (conexiune_clk),
    .rst_n_o (conexiune_rst_n)
);

wire [3:0] data_load;
wire [3:0] data_counter;
wire enable;
wire count_up;
wire count_down;
wire load;
wire overflow;
wire underflow;
wire shift_register_out;
wire comparator_out;

// Instantiati generatorul pentru scenariul de testare
gen_scenariu_testare #(
    .NUMAR_BITI(4)
) scenraiu_1 (
    .clk_i      (conexiune_clk     ),
    .rst_n_i    (conexiune_rst_n   ),
    .underflow_i(underflow         ),
    .overflow_i (shift_register_out),
    
    // Intrarile din numarator devin iesiri pentru modulul
    // care genereaza stimulii de testare.
    .enable_o(enable),
    .load_o(load),
    .data_o(data_load),
    .count_up_o(count_up),
    .count_down_o (count_down)
);
// Instantiati numaratorul
counter #(
    .NUMAR_BITI(4)
) Counter(
    .clk_i       (conexiune_clk) ,
    .rst_n_i     (conexiune_rst_n) ,
    .data_i      (data_load) ,
    .enable_i    (enable) ,
    .load_i      (load) ,
    .count_up_i  (count_up) ,
    .count_down_i(count_down) ,
				 
    .data_o      (data_counter) ,
    .overflow_o  (overflow) ,
    .underflow_o (underflow) 
);
// Instantiati comparatorul
 comparator #(
    .NUMAR_BITI(4)
) Comparator(
    .first_number_in (data_counter) ,
    .second_number_in(4'd10) ,
					 
    .numbers_equal_o (comparator_out)
);
// Instantiati registrul de shiftare


shift_register Shift_register(
   .clk_i   (conexiune_clk     ),
   .rst_n_i (conexiune_rst_n   ),
   .data_i  (overflow          ),
   .data_o  (shift_register_out)    
);
endmodule