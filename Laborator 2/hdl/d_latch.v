////////////////////////////////////////////////////////////////////////////////
// Nume modul: d_latch
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un latch de tip D. 
//
// Modificari:
//   18/03/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module d_latch (
    input       clk_i   ,  // Intrarea de ceas a modulului
    input       d_i     ,  // Intrarea de date a modulului
    output reg  q_o     ,  // Ieșirea Q a modulului, declarată de tip reg
    output reg  not_q_o    // Ieșirea ~Q a modulului, declarată de tip reg
);


// Prin utilizarea caracterului "*" în lista de senzitivități sunt
// luate în calcul modificările oricărui semnal din modul pentru
// evaluarea expresiei always.
always @(*) begin
    if(clk_i) begin
        q_o <= d_i;
        not_q_o <= ~d_i;
    end
end

    
endmodule