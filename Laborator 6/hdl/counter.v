////////////////////////////////////////////////////////////////////////////////
// Nume modul: counter
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un numarator cu diverse functii.
//
// Modificari:
//   02/04/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module counter #(
    parameter NUMAR_BITI = 8
) (
    input                  clk_i        ,
    input                  rst_n_i      ,
    input [NUMAR_BITI-1:0] data_i       ,
    input                  enable_i     ,
    input                  load_i       ,
    input                  count_up_i   ,
    input                  count_down_i ,
    input                  clear_i      ,

    output[NUMAR_BITI-1:0] data_o       ,
    output                 overflow_o   ,
    output                 underflow_o  
);


// Declarati un semnal inter de tip reg numit data_internal
reg [NUMAR_BITI-1:0] data_internal;

// Modelati comportamentul pentru data_internal 
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) data_internal <= 'b0;
    else if (enable_i) begin
        if (clear_i)            data_internal <= 'b0;
        else if (load_i)        data_internal <= data_i;
        else if (count_up_i)    data_internal <= data_internal + 1;
        else if (count_down_i)  data_internal <= data_internal - 1;
        else                    data_internal <= data_internal;                   
    end
    else                        data_internal <= data_internal;   
end


// Atribuiti iesirilor modulului valorile corespunzatoare
assign data_o = data_internal;
assign overflow_o = enable_i & (~load_i) & count_up_i & (&data_internal);
assign underflow_o = enable_i & (~load_i) & (~count_up_i) & count_down_i &  ~(|data_internal);


endmodule