////////////////////////////////////////////////////////////////////////////////
// Nume modul: control_unit
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza logica de control pentru procesor.
//
// Modificari:
//   21/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module control_unit (
    input          clk_i                         ,
    input          rst_n_i                       ,

    output  [3:0]  data_ram_address_o            , // Porturile pentru memoria de date 
    output         data_ram_we_o                 , // Porturile pentru memoria de date 
    output         data_ram_ce_o                 , // Porturile pentru memoria de date 
     
    output         instruction_ram_we_o         , // Porturile pentru memoria de instructiuni 
    output         instruction_ram_ce_o         , // Porturile pentru memoria de instructiuni 
    input   [22:0] instruction_ram_read_data_i  , // Porturile pentru memoria de instructiuni

    output         program_counter_enable_o     , // Porturile pentru program counter
    
    output  [2:0]  alu_operation_select_o       , // Porturile pentru ALU
    output  [7:0]  alu_op1_o                    , // Porturile pentru ALU
    output  [7:0]  alu_op2_o                      // Porturile pentru ALU

);

localparam STATE_FETCH   = 0;
localparam STATE_DECODE  = 1;
localparam STATE_EXECUTE = 2;

reg [1:0] state;

always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) state <= STATE_FETCH;
    else
        case (state)    
            STATE_FETCH   : state <= STATE_DECODE ;
            STATE_DECODE  : state <= STATE_EXECUTE;
            STATE_EXECUTE : state <= STATE_FETCH  ;
            default: state <= STATE_FETCH  ;
        endcase
end

// Modelarea decodarii instructiunilor
reg [2:0] operation;
reg [7:0] operand_1;
reg [7:0] operand_2;
reg [3:0] data_mem_addr;

always @(posedge clk_i or negedge rst_n_i) begin
    if      (~rst_n_i)              operation <= 'b0;
    else if (state == STATE_DECODE) operation <= instruction_ram_read_data_i[22:20];
    else                            operation <= 0;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if      (~rst_n_i)              operand_1 <= 'b0;
    else if (state == STATE_DECODE) operand_1 <= instruction_ram_read_data_i[19:12];
    else                            operand_1 <= 0;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if      (~rst_n_i)              operand_2 <= 'b0;
    else if (state == STATE_DECODE) operand_2 <= instruction_ram_read_data_i[11:4];
    else                            operand_2 <= 0;
end

always @(posedge clk_i or negedge rst_n_i) begin
    if      (~rst_n_i)              data_mem_addr <= 'b0;
    else if (state == STATE_DECODE) data_mem_addr <= instruction_ram_read_data_i[3:0];
    else                            data_mem_addr <= 0;
end

// Modelarea comportamentului porturilor pentru memoria de date
assign data_ram_address_o = (state == STATE_EXECUTE)?  data_mem_addr : 0;           
assign data_ram_we_o      = (state == STATE_EXECUTE)?  1 : 0;          
assign data_ram_ce_o      = (state == STATE_EXECUTE)?  1 : 0;         

// Modelarea comportamentului porturilor pentru memoria de instructiuni
assign instruction_ram_we_o = 0;           
assign instruction_ram_ce_o = (state == STATE_FETCH)?  1 : 0;  

// Modelarea comportamentului porturilor pentru program counter
assign program_counter_enable_o  = (state == STATE_FETCH)?  1 : 0; 

// Modelarea comportamentului porturilor pentru memoria de date
assign alu_operation_select_o = (state == STATE_EXECUTE)? operation : 0 ;     
assign alu_op1_o              = (state == STATE_EXECUTE)? operand_1 : 0 ;    
assign alu_op2_o              = (state == STATE_EXECUTE)? operand_2 : 0 ;    
                   

endmodule