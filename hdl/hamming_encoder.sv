/****************************************************************
 * hamming_encoder.sv - hamming encoder
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 19th October, 2021
 *
 * Description   :
 * -----------
 * encodes into (7,4) code
 * 7 = total bits
 * 4 = data bits
 ****************************************************************/

module ham_encoder
(
	input  logic [3:0] data,
	output logic [6:0] ham_code
);

logic [2:0] parity;

always_comb begin
	parity[0] = data[0] ^ data[1] ^ data[3];
	parity[1] = data[0] ^ data[2] ^ data[3];
	parity[2] = ^data[3:1];
end

assign ham_code = { data[3:1], parity[2], data[0], parity[1:0]};

endmodule : ham_encoder
