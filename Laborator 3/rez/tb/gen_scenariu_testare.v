////////////////////////////////////////////////////////////////////////////////
// Nume modul: gen_scenariu_testare
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un generator pentru scenariul de testare descris 
//   in laborator. 
//
// Modificari:
//   02/04/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////
module gen_scenariu_testare#(
    parameter NUMAR_BITI = 8
) (
    input clk_i,
    input rst_n_i,
    input underflow_i,
    input overflow_i,
    
    // Intrarile din numarator devin iesiri pentru modulul
    // care genereaza stimulii de testare.
    output reg enable_o,
    output reg load_o,
    output reg [NUMAR_BITI-1:0] data_o,
    output reg count_up_o,
    output reg count_down_o 
);

initial begin
	#1;
    enable_o <= 'b0;
    load_o   <= 'b0;
    data_o   <= 'd0;
    count_up_o <= 'b0;
    count_down_o <= 'b0;
    
    // Asteptam finalizarea reset-ului
	@(posedge rst_n_i);
    
	// Setam stimulii pentru numarare crescatoare
	count_up_o <= 1'b1;
	enable_o <= 1'b1;
    
	// Asteptam 3 tacte de ceas
	repeat (3) @(posedge clk_i);
    
	// Setam stimulii pentru mentinerea valorii
	enable_o <= 1'b0;
    
	// Asteptam 2 tacte de ceas
	repeat (2) @(posedge clk_i);
    // Setam valoarea pentru date si comanda de incarcare
	enable_o <= 1'b1;
	load_o   <= 1'b1;
	data_o 	 <= 'd12;
	@(posedge clk_i);
	
    // Setam sensul numararii descrescatoare
	count_up_o   <= 1'b0;
	count_down_o <= 1'b1;
	load_o 		 <=	1'b0;
	@(posedge clk_i);
    
	// Asteptam setarea semnalului de overflow
	@(posedge underflow_i);
	@(posedge clk_i);
	

    // Schimbam sensul numararii
	count_up_o <= 1'b1;
	@(posedge clk_i);
	
    // Asteptam setarea semnalului de overflow
	@(posedge overflow_i);
	repeat (2) @(posedge clk_i);
    // Oprim simularea folosind directiva $stop

    $stop;

end
    
endmodule