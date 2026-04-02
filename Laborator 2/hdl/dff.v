////////////////////////////////////////////////////////////////////////////////
// Nume modul: dff
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un bistabil de tip D. 
//
// Modificari:
//   18/03/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module dff (
    input       clk_i   ,  // Intrarea de ceas a modulului
    input       d_i     ,  // Intrarea de date a modulului
    output reg  q_o     ,  // Ieșirea Q a modulului, declarată de tip reg
    output reg  not_q_o    // Ieșirea ~Q a modulului, declarată de tip reg
);


// Modelarea variabilelor de tip reg se face utilizând construcția always
// Instrucțiunile dintre cuvintele cheie begin si end se execută de fiecare
// dată atunci când semnalele din paranteză își modifică valoarea. 
// În cazul de față, instrucțiunile se execută pe fiecare front pozitiv al semnalului clk_i.
// Semnalele care se află în paranteză poartă numele de listă de senzitivități.
always @(posedge clk_i) begin
    q_o <= d_i;
    not_q_o <= ~d_i;
end

    
endmodule