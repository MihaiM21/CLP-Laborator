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
localparam INIT       		= 0;
localparam PORNIRE_CENTRALA = 1;
localparam SETARE_TEMP      = 2;
// Declarati registrii de stare
reg [1:0] starea_curenta;
reg [1:0] starea_viitoare;

	
// Declarati registrul pentru stocarea temperaturii dorite
reg[5:0] desired_temp;
// Implementati automatul de stare
//partea sincrona

always @(posedge clk_i or negedge rst_n_i) begin
	if(~rst_n_i) starea_curenta <= INIT;
	else       	 starea_curenta <= starea_viitoare;
end

//partea combinationala
always @(*)
begin
	case(starea_curenta)
	INIT: if(set_desired_temp_i) 					        starea_viitoare <= SETARE_TEMP;
			else if(measured_temp_i < desired_temp -2)      starea_viitoare <= PORNIRE_CENTRALA;
			else 									        starea_viitoare <= INIT;
	SETARE_TEMP: if(measured_temp_i >= desired_temp)        starea_viitoare <= INIT;
				else if(measured_temp_i < desired_temp)     starea_viitoare <= PORNIRE_CENTRALA;
	PORNIRE_CENTRALA: if(measured_temp_i >= desired_temp+2) starea_viitoare <= INIT;		
					else                                    starea_viitoare <= PORNIRE_CENTRALA;
	default:                                                starea_viitoare <= INIT;
	endcase
end
// Modelati comportamentul registrului de stocare a temperaturii dorite
always @(posedge clk_i or negedge rst_n_i) begin
	if(~rst_n_i) desired_temp <= 'd20;
	else if(starea_curenta == SETARE_TEMP) desired_temp <= desired_temp_i;
	end
// Atribuiti valori iesirii
 
assign enable_o =(starea_curenta == PORNIRE_CENTRALA);

endmodule