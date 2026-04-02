////////////////////////////////////////////////////////////////////////////////
// Nume modul: dff_with_rst
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un bistabil de tip D care are atât reset sincron cât și reset asincron. 
//
// Modificari:
//   18/03/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module dff_with_rst (
    input       clk_i          ,  // Intrarea de ceas a modulului
    input       rst_async_n_i  ,  // Intrarea de reset asincronă a modulului, activă in 0
    input       rst_sync_n_i   ,  // Intrarea de reset sincronă a modulului, activă in 0
    input       d_i            ,  // Intrarea de date a modulului
    output reg  q_o            ,  // Ieșirea Q a modulului, declarată de tip reg
    output      not_q_o           // Ieșirea ~Q a modulului
);


// Semnalul de reset asincron a fost adăugat în lista de senzitivități
// Cuvântul cheie negedge indică faptul că frontul negativ al semnalului rst_async_n_i va fi
// luat în considerare pentru always
always @(posedge clk_i or negedge rst_async_n_i) begin
    if(~rst_async_n_i)      q_o <= 0;  // În cazul în care rst_async_n_i are valoarea 0, ieșirea primește valoarea 0
    else if(~rst_sync_n_i)  q_o <= 0;  // În cazul în care rst_sync_n_i are valoarea 0, ieșirea primește valoarea 0
    else                    q_o <= d_i;
end

assign not_q_o = ~q_o;
    
endmodule