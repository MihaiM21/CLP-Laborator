////////////////////////////////////////////////////////////////////////////////
// Nume modul: generator_stimuli
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza generatorul de stimuli pentru multiplexor si decodor.
//
// Modificari:
//   01/12/2023 | Stefan Gheorghe | Varianta initiala
// 
// Note:
//   Deoarece vrem sa controlam cele 3 intrari ale portii AND avem nevoie sa
//   generam 3 iesiri.
////////////////////////////////////////////////////////////////////////////////

module generator_stimuli (
    output a_o,   // iesirea a
    output b_o,   // iesirea b
    output c_o,   // iesirea c
    output d_o    // iesirea d
);

reg [3:0] counter; // declaram o variabila interna modulului de tip reg cu latimea de 3 biti

initial begin 
    counter <= 0; // atribuim variabile counter valoarea intiala 0
    
    // instructiunea repeat(x) indica faptul ca liniile de cod  cuprinse 
    // intre begin si end se vor repeta de x ori
    repeat(32)    
    begin
        #5;   // simulatorul va astepta 5 unitati de timp de simulare pana va executa urmatoarea instructiune
        counter <= counter + 1; // valoarea counter-ului este incrementata cu 1
    end

    $stop; // aceasta comanda este apelata la finalul simularii pentru a o opri
end

assign a_o = counter[0];
assign b_o = counter[1];
assign c_o = counter[2];
assign d_o = counter[3];
    
endmodule