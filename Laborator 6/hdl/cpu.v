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
    .clk_i                      (clk_i),
    .rst_n_i                    (rst_n_i),
    .data_ram_address_o         (data_ram_address),
    .data_ram_we_o              (data_ram_we),
    .data_ram_ce_o              (data_ram_ce),
    .instruction_ram_we_o       (instruction_ram_we),
    .instruction_ram_ce_o       (instruction_ram_ce),
    .instruction_ram_read_data_i(instruction_ram_read_data),
    .program_counter_enable_o   (program_counter_enable),
    .alu_operation_select_o     (alu_operation_select),
    .alu_op1_o                  (alu_op1),
    .alu_op2_o                  (alu_op2)
);

// Instantiati ALU
alu ALU_INST(
    .operation_select_i (alu_operation_select),
    .op1_i              (alu_op1),
    .op2_i              (alu_op2),
    .result_o           (alu_result)
);


// Instantiati memoria de date
mem_1rw #(
  .ADDR_WIDTH(4),
  .DATA_WIDTH(8)
) DATA_MEM_INST (
    .clk_i     (clk_i),
    .wr_data_i (alu_result),
    .address_i (data_ram_address),
    .we_i      (data_ram_we),
    .ce_i      (data_ram_ce),
    .rd_data_o ()   // Portul nu este utilizat pentru memoria de date
); 

// Instantiati memoria de instructiuni
mem_1rw #(
  .ADDR_WIDTH(4),
  .DATA_WIDTH(23)
) INSTR_MEM_INST (
    .clk_i     (clk_i),
    .wr_data_i (23'b0),
    .address_i (program_counter_data_out),
    .we_i      (instruction_ram_we),
    .ce_i      (instruction_ram_ce),
    .rd_data_o (instruction_ram_read_data)
); 

// Instantiati program counter

counter  #(
    .NUMAR_BITI(4)
) PROGRAM_COUNTER(
    .clk_i        (clk_i),
    .rst_n_i      (rst_n_i),
    .data_i       (4'b0),
    .enable_i     (program_counter_enable),
    .load_i       (1'b0),
    .count_up_i   (1'b1),
    .count_down_i (1'b0),
    .clear_i      (1'b0),
    .data_o       (program_counter_data_out),
    .overflow_o   (program_execution_done_o),
    .underflow_o  ()
);


endmodule