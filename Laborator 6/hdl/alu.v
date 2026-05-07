////////////////////////////////////////////////////////////////////////////////
// Nume modul: alu
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza logica pentru operatiile disponibile 
//   ale procesorului.
//
// Modificari:
//   21/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module alu (
    input      [2:0] operation_select_i,
    input      [7:0] op1_i             ,
    input      [7:0] op2_i             ,
    output reg [7:0] result_o
);

localparam AND_OP_CODE = 3'b000;
localparam ORR_OP_CODE = 3'b001;
localparam XOR_OP_CODE = 3'b010;
localparam MOV_OP_CODE = 3'b011;
localparam ADD_OP_CODE = 3'b100;
localparam SUB_OP_CODE = 3'b101;
localparam SHL_OP_CODE = 3'b110;
localparam SHR_OP_CODE = 3'b111;

always @(*) begin
    case (operation_select_i)
    AND_OP_CODE: result_o <= op1_i & op2_i;
    ORR_OP_CODE: result_o <= op1_i | op2_i;
    XOR_OP_CODE: result_o <= op1_i ^ op2_i;
    MOV_OP_CODE: result_o <= op1_i;
    ADD_OP_CODE: result_o <= op1_i + op2_i;
    SUB_OP_CODE: result_o <= op1_i - op2_i;
    SHL_OP_CODE: result_o <= op1_i << op2_i;
    SHR_OP_CODE: result_o <= op1_i >> op2_i;
    default: result_o <= op1_i;
endcase
end

    
endmodule