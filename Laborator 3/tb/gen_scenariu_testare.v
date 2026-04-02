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
    enable_o <= 'b0;
    load_o   <= 'b0;
    data_o   <= 'd0;
    count_up_o <= 'b0;
    count_down_o <= 'b0;
    
    // Asteptam finalizarea reset-ului
    @(negedge rst_n_i);
    @(posedge rst_n_i);

    // Setam stimulii pentru comanda dorita
    count_up_o <= 1'b1;
    enable_o <= 1'b1;

    // Asteptam 3 tacte de ceas
    repeat (3) @(posedge clk_i);

    // Setam comanda dorita 
    count_up_o <= 0;

    // Asteptam 2 tacte de ceas
    repeat (2) @(posedge clk_i);

    // Setam valoarea pentru date si comanda de incarcare
    load_o   <= 1;
    data_o 	 <= 'd12;
    @(posedge clk_i);

    // Setam sensul numararii
    count_down_o <= 1'b1;
    load_o <= 0;

    // Asteptam setarea semnalului de underflow
    @(posedge underflow_i);

    // Schimbam sensul numararii
    count_up_o <= 1;


    // Asteptam setarea semnalului de overflow
    @(posedge overflow_i);
    repeat (2) @(posedge clk_i);
    // Oprim simularea folosind directiva $stop

    $stop;

end
    
endmodule