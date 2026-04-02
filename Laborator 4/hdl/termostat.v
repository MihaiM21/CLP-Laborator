////////////////////////////////////////////////////////////////////////////////
// Nume modul: termostat
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza termostatul descris in laboratorul 5.
//
// Modificari:
//   16/04/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module termostat (
    input        clk_i               ,
    input        rst_n_i             ,
    input [5:0]  desired_temp_i      ,
    input        set_desired_temp_i  ,
    input [5:0]  measured_temp_i     ,
    output       enable_o            
);


// Definiti parametrii locali pentru codarea starilor
localparam INIT = 0;
localparam SETARE_TEMP = 1;
localparam PORNIRE_CENTRALA = 2;
// Declarati registrii de stare
reg[1:0] stare_curenta;

// Declarati registrul pentru stocarea temperaturii dorite
reg[5:0] temperatura_dorita;
// Implementati automatul de stare
always @(posedge clk_i or negedge rst_n_i) begin
    if(~rst_n_i) stare_curenta <= INIT;
    else begin
        case (stare_curenta)
            INIT: if(measured_temp_i < desired_temp_i - 2) stare_curenta <= PORNIRE_CENTRALA;
                else if(set_desired_temp_i) stare_curenta <= SETARE_TEMP;
                else stare_curenta <= INIT;
            SETARE_TEMP: if(measured_temp_i < desired_temp_i - 2) stare_curenta <= PORNIRE_CENTRALA;
                else stare_curenta <= INIT;
            PORNIRE_CENTRALA: if(set_desired_temp_i) stare_curenta <= SETARE_TEMP;
                else if(measured_temp_i > desired_temp_i + 2) stare_curenta <= INIT;
                else stare_curenta <= PORNIRE_CENTRALA;
            default: stare_curenta <= INIT;
        endcase
    end
end

// Modelati comportamentul registrului de stocare a temperaturii dorite
always @(posedge clk_i or negedge rst_n_i) begin
    if(~rst_n_i) temperatura_dorita <= 'd20;
    else if(stare_curenta == SETARE_TEMP) temperatura_dorita <= desired_temp_i;
end

// Atribuiti valori iesirii
assign enable_o = (stare_curenta == PORNIRE_CENTRALA);
endmodule