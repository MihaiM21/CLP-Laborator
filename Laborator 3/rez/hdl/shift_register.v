////////////////////////////////////////////////////////////////////////////////
// Nume modul: shift_register
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un registru de deplasare pe 4 biti.
//
// Modificari:
//   30/03/2025 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module shift_register (
    input                  clk_i        ,
    input                  rst_n_i      ,
    input                  data_i       ,
    output                 data_o       
);


// Declarati un semnal intern de tip reg pe 4 biti\
reg [3:0] shift_reg_internal;

// Modelati comportamentul pentru semnalul declarat 
always @(posedge clk_i or negedge rst_n_i) begin
	if(~rst_n_i) shift_reg_internal <= 'b0;
	else 		 shift_reg_internal <= {shift_reg_internal[2:0], data_i};
end

// Atribuiti iesirilor modulului valorile corespunzatoare
   assign data_o = shift_reg_internal[3];
endmodule