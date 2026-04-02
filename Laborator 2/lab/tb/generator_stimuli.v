////////////////////////////////////////////////////////////////////////////////
// Nume modul: generator_stimuli
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza generatorul de stimuli parametrizabil.
//
// Modificari:
//   18/12/2023 | Stefan Gheorghe | Varianta initiala
// 
// Note:
//   Deoarece vrem să generăm toate variantele posibile pentru un număr N de biți,
//   ieșirea generatorului de stimuli va avea un număr de biți parametrizabil.   
//   Vom folosi un counter, similar cu laboratorul 1.
////////////////////////////////////////////////////////////////////////////////

module generator_stimuli#(
    parameter NR_BITI = 8 // definirea unui parametru cu numele NR_BITI.
                           // dacă acesta nu este suprascris in momentul instațierii modulului, își va păstra valoarea default 8
) (
    output [NR_BITI-1:0] stimuli_o   // iesirea stimuli_o are un număr de biți egal cu parametrul declarat mai sus
);

reg [NR_BITI-1:0] counter; // declaram o variabila interna modulului de tip reg cu latimea de NR_BITI biti

initial begin 
    counter <= 0; // atribuim variabile counter valoarea intiala 0
    
    // instructiunea repeat(x) indica faptul ca liniile de cod  cuprinse 
    // intre begin si end se vor repeta de x ori
    // Pentru a genera toate variantele posibile, bucla se va repeta de NR_BITI ori
    repeat(2 ** NR_BITI)    
    begin
        #3;   // simulatorul va astepta 3 unitati de timp de simulare pana va executa urmatoarea instructiune
        counter <= counter + 1; // valoarea counter-ului este incrementata cu 1
    end

    $stop; // aceasta comanda este apelata la finalul simularii pentru a o opri
end

assign stimuli_o = counter;

endmodule