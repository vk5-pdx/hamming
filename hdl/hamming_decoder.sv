/****************************************************************
 * hamming_decoder.sv - hamming decoder
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 19th October, 2021
 *
 * Description   :
 * -----------
 * decodes (7,4) hamming code
 * 7 = total bits
 * 4 = data bits
 ****************************************************************/

module ham_decoder
(
	input  logic [6:0] ham_code,
	output logic [3:0] data_out
);

logic [2:0] parity;

assign parity[0] = ham_code[0] ^ ham_code[2] ^ ham_code[4] ^ ham_code[6];
assign parity[1] = ham_code[1] ^ ham_code[2] ^ ham_code[5] ^ ham_code[6];
assign parity[2] = ^ham_code[6:3];

logic [6:0] error_pattern;      // assuming 1 bit error
logic [6:0] corrected_ham_code;

always_comb begin
	unique case (parity)
		3'b000: error_pattern = 7'b0000000;
		3'b001: error_pattern = 7'b0000001;
		3'b010: error_pattern = 7'b0000010;
		3'b011: error_pattern = 7'b0000100;
		3'b100: error_pattern = 7'b0001000;
		3'b101: error_pattern = 7'b0010000;
		3'b110: error_pattern = 7'b0100000;
		3'b111: error_pattern = 7'b1000000;
	endcase
end

assign corrected_ham_code = error_pattern ^ ham_code;                // flipping error bit
assign data_out = { corrected_ham_code[6:4], corrected_ham_code[2]}; // extracting data

endmodule : ham_decoder
