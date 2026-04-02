////////////////////////////////////////////////////////////////////////////////
// Nume modul: register_param_width
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează registru de lățime parametrizabilă cu reset asincron activ în 0. 
//
// Modificari:
//   18/03/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module register_param_width #(
    parameter REGISTER_WIDTH = 4
)(
    input                        clk_i             ,  // Intrarea de ceas a modulului
    input                        rst_async_n_i     ,  // Intrarea de reset asincronă a modulului, activă in 0
    input  [REGISTER_WIDTH-1:0]  data_i            ,  // Intrarea de date a modulului
    output [REGISTER_WIDTH-1:0]  data_o               // Ieșirea de date a modulului
);

// Declarați o variabilă internă de tip reg cu numele data_internal și cu lățimea egală cu REGISTER_WIDTH
reg [REGISTER_WIDTH-1:0] data_internal;

// Modificați structura always adăugând în lista de senzitivități frontul negativ al semnalului de reset
always @(posedge clk_i or negedge rst_async_n_i) begin // daca scot a doua conditie or negedge... resetul devine syncron pe ceas.
    if(~rst_async_n_i) data_internal <= 32'b0; // valoare cunoscuta
	else 
	// Modificați codul astfel încât dacă reset-ul este activ, variabila internă data_internal să primească valoarea 0
    data_internal <= data_i;
end

// Atribuiți ieșirii data_o valoarea din variabila data_internal
    assign data_o = data_internal;
endmodule