////////////////////////////////////////////////////////////////////////////////
// Nume modul: gen_stimuli_mem
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un generator parametrizabil pentru clock si reset. 
//   Reset-ul este activ in 0.  
//
// Modificari:
//   08/05/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module gen_stimuli_mem#(
    parameter ADDR_WIDTH = 4,
    parameter DEPTH = 2**ADDR_WIDTH,
    parameter DATA_WIDTH = 32
) (
    input                        clk_i     ,
    output reg  [DATA_WIDTH-1:0] wr_data_i ,
    output reg  [ADDR_WIDTH-1:0] address_i ,
    output reg                   we        ,
    output reg                   ce        ,
    input      [DATA_WIDTH-1:0]  rd_data_o 
    
);


// Declarati o variabila bidimensionala
reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

// Folosind un bloc "initial" initializati memoria folosind fisierul data.memh
initial 
begin
	$readmemh("data.memh", memory);

end

reg [DATA_WIDTH-1:0] date_pentru_verificare;

initial begin
    wr_data_i <=0;
    address_i <=0;
    we<=0;
    ce<=0;
    
    repeat(5) @(posedge clk_i);
    repeat(3) begin
        ce<=1;
        we<=1;
        wr_data_i<= 'haaaabbbb;
        address_i<=$random;
        @(posedge clk_i);

        we<=0;
        @(posedge clk_i);
        #1
        date_pentru_verificare<=rd_data_o;
        #1
        if(date_pentru_verificare=='haaaabbbb)begin
            $display("OK");
        end
        else begin
            $display("NOT OK");
        end
        @(posedge clk_i);
    end

    address_i<=0;
    @(posedge clk_i);
    #1
    date_pentru_verificare<=rd_data_o;
    #1
    if(date_pentru_verificare==memory[address_i])begin
        $display("OK");
    end
    else begin
        $display("NOT OK");
    end
    @(posedge clk_i);

    repeat(5) @(posedge clk_i);
    $stop;
end
    
endmodule