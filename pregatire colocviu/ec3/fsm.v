module fsm (
    input clk_i,
    input rst_n_i,
    input data,
    output secv_gasita
);


localparam INIT=0;
localparam BIT1=1;
localparam BIT2=2;
localparam BIT3=3;

reg [1:0] stare_curenta;

always @(posedge clk_i or negedge rst_n_i) begin
    if(~rst_n_i) stare_curenta <= INIT;
    else begin
        case (stare_curenta)
            INIT: if(data) stare_curenta <= BIT1;
                else stare_curenta <= INIT;
            BIT1: if(~data) stare_curenta <= BIT2;
                else stare_curenta <= BIT1;
            BIT2: if(data) stare_curenta <= BIT3;
                else stare_curenta <= INIT;
            BIT3: stare_curenta <= INIT;
            default: stare_curenta <= INIT;
        endcase
    end
end

assign secv_gasita = (stare_curenta == BIT3);

endmodule