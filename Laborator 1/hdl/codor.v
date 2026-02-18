////////////////////////////////////////////////////////////////////////////////
// Nume modul: codor
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza un codor 4:2 cu o ieșire adițională ce indică
//   prezența la intrarea circuitului a unei combinații în care cel puțin un bit are valoarea 1.
//
// Modificari:
//   18/12/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////


module codor (
    input           a_i    ,   // intrarea a
    input           b_i    ,   // intrarea b
    input           c_i    ,   // intrarea c
    input           d_i    ,   // intrarea d
    output [1:0]    y_o    ,   // iesirea y
    output          valid_o    // iesirea valid
);

// Completați liniile de mai jos pe baza tabelului de adevăr din laborator (Figura 3)
assign valid_o = a_i | b_i | c_i | d_i ;

assign y_o[0] = (~a_i & b_i) | (~c_i & d_i & ~a_i & ~b_i);

wire var_1;
assign  var_1 = ~a_i & ~b_i & c_i;
wire var_2;
assign var_2 = ~a_i & ~b_i & ~c_i & d_i;

assign y_o[1] = var_1 | var_2;

endmodule

