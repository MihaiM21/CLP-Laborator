////////////////////////////////////////////////////////////////////////////////
// Nume modul: mem_1rw
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza o memorie single-port.
//
// Modificari:
//   08/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module mem_1rw#(
    parameter ADDR_WIDTH = 4,
    parameter DEPTH = 2**ADDR_WIDTH,
    parameter DATA_WIDTH = 32
) (
    input                        clk_i     ,
    input [DATA_WIDTH-1:0]       wr_data_i ,
    input [ADDR_WIDTH-1:0]       address_i ,
    input                        we_i      ,
    input                        ce_i      ,
    output reg [DATA_WIDTH-1:0]  rd_data_o 
);


// Declarati o variabila bidimensionala urmand exemplul din laborator
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

// Modelati comportamentul variabilei declarate anterior
always @(posedge clk_i) begin
    if(ce_i)
    begin
        if(we_i) mem[address_i] <= wr_data_i;
    end
end

// Modelati comportamentul registrului rd_data_o
always @(posedge clk_i)
begin
    if(ce_i & ~we_i) rd_data_o <= mem[address_i];
    else             rd_data_o <= 'b0;
end


endmodule