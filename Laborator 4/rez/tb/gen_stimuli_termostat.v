////////////////////////////////////////////////////////////////////////////////
// Nume modul: gen_stimuli_termostat
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul genereaza semnalele de intrare pentru termostat.
//   De asemenea, sunt afisate in consola simulatorului valorile pentru temperatura setata si
//   temperatura masurata.
//
// Modificari:
//   16/04/2023 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module gen_stimuli_termostat (
    input             clk_i               ,
    input             rst_n_i             ,
    input             enable_i            ,
    output reg [5:0]  desired_temp_o      ,
    output reg        set_desired_temp_o  ,
    output reg [5:0]  measured_temp_o     


);


initial begin

    // La inceputul simularii toate iesirile au valoarea 0
    desired_temp_o     <= 0;
    set_desired_temp_o <= 0;
    measured_temp_o    <= 27;
   
    // Se asteapta finalizarea reset-ului
    @(negedge rst_n_i);
    @(posedge rst_n_i);
    @(posedge clk_i);
   
    
    // Se configureaza temperatura dorita si se genereaza
    // o valoare pentru temperatura masurata
    desired_temp_o     <= 'd25;
    set_desired_temp_o <= 'd1;
    measured_temp_o    <= 'd27;
    $display("Temperatura setata: %d  Temperatura ambianta: %d" ,desired_temp_o,measured_temp_o);
    $display("Comanda pentru centrala: %d" ,enable_i);

    @(posedge clk_i);
    
    set_desired_temp_o <= 'd0;
    
    @(posedge clk_i);
    // Se scade valoarea temperaturii masurate
    repeat(5)begin
        measured_temp_o    <= measured_temp_o - 1;
        $display("Temperatura setata: %d  Temperatura ambianta: %d" ,desired_temp_o,measured_temp_o);
        $display("Comanda pentru centrala: %d" ,enable_i);
        @(posedge clk_i);
    end

    repeat(10)begin
        // Se creste valoarea temperaturii masurate
        measured_temp_o    <= measured_temp_o + 1;
        $display("Temperatura setata: %d  Temperatura ambianta: %d" ,desired_temp_o,measured_temp_o);
        $display("Comanda pentru centrala: %d" ,enable_i);
        @(posedge clk_i);
    end
    
    repeat(5) @(posedge clk_i);

    $stop;

end
    
endmodule