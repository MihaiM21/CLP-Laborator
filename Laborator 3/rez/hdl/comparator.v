////////////////////////////////////////////////////////////////////////////////
// Nume modul: comparator
// Autor: Stefan Gheorghe
// Descriere: 
//   Acest modul implementează un comparator care semnaleaza daca doua numere sunt egale.
//
// Modificari:
//   02/04/2024 | Stefan Gheorghe | Varianta initiala
//
////////////////////////////////////////////////////////////////////////////////

module comparator #(
    parameter NUMAR_BITI = 8
) (
    input [NUMAR_BITI-1:0] first_number_in  ,
    input [NUMAR_BITI-1:0] second_number_in ,

    output                 numbers_equal_o
);

// Modelati iesirea numbers_equal_o folosind instructiunea assign
	assign numbers_equal_o = (first_number_in == second_number_in);

endmodule