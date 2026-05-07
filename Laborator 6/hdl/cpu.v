////////////////////////////////////////////////////////////////////////////////
// Nume modul: cpu
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementeaza procesorul descris in laborator.
//
// Modificari:
//   21/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module cpu (
    input  clk_i                    , 
    input  rst_n_i                  ,
    output program_execution_done_o 
);

// Declarati conexiunile necesare
wire [3:0] data_ram_address;
wire data_ram_we;
wire data_ram_ce; 

wire [7:0] alu_result;

wire [22:0] instruction_ram_read_data;
wire instruction_ram_we;
wire instruction_ram_ce;

wire [3:0] program_counter_data_out;

wire program_counter_enable;

wire [2:0] alu_operation_select ;
wire [7:0] alu_op1              ;
wire [7:0] alu_op2              ;

// Instantiati unitatea de control
control_unit CONTROL_UNIT_INST(
    .clk_i                      (),
    .rst_n_i                    (),
    .data_ram_address_o         (),
    .data_ram_we_o              (),
    .data_ram_ce_o              (),
    .instruction_ram_we_o       (),
    .instruction_ram_ce_o       (),
    .instruction_ram_read_data_i(),
    .program_counter_enable_o   (),
    .alu_operation_select_o     (),
    .alu_op1_o                  (),
    .alu_op2_o                  ()
);

// Instantiati ALU
alu ALU_INST(
    .operation_select_i (),
    .op1_i              (),
    .op2_i              (),
    .result_o           ()
);


// Instantiati memoria de date
mem_1rw #(
  .ADDR_WIDTH(4),
  .DATA_WIDTH(8)
) DATA_MEM_INST (
    .clk_i     (),
    .wr_data_i (),
    .address_i (),
    .we_i      (),
    .ce_i      (),
    .rd_data_o ()   // Portul nu este utilizat pentru memoria de date
); 

// Instantiati memoria de instructiuni
mem_1rw #(
  .ADDR_WIDTH(4),
  .DATA_WIDTH(23)
) INSTR_MEM_INST (
    .clk_i     (),
    .wr_data_i (),
    .address_i (),
    .we_i      (),
    .ce_i      (),
    .rd_data_o ()
); 

// Instantiati program counter

counter  #(
    .NUMAR_BITI(4)
) PROGRAM_COUNTER(
    .clk_i        (),
    .rst_n_i      (),
    .data_i       (),
    .enable_i     (),
    .load_i       (),
    .count_up_i   (),
    .count_down_i (),
    .clear_i      (),
    .data_o       (),
    .overflow_o   (),
    .underflow_o  ()
);


endmodule