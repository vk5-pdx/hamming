/****************************************************************
 * hamming_encoder.sv - hamming encoder
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 19th October, 2021
 *
 * Description   :
 * -----------
 * encodes into 11-7-1 hamming code
 * 11 = total bits after encoding
 * 7  = data bits
 * 1  = maximum errors that can be corrected
 ****************************************************************/

module ham_encoder
#(
	parameter PARITY_BITS = 3;

	// do not edit these
	parameter DATA_WIDTH = 2**PARITY_BITS - 1;
	parameter CODE_WIDTH = 2**PARITY_BITS - PARITY_BITS -1;
)
(
	input  logic [WIDTH:1]    data,
	output logic [CODE_WIDTH:1] ham_code
);

// verifying if user entered parameters
localparam CALC_DATA_WIDTH = 2**PARITY_BITS - 1;
localparam CALC_CODE_WIDTH = 2**PARITY_BITS - PARITY_BITS -1;

generate if(CALC_DATA_WIDTH != DATA_WIDTH)
	$fatal("Wrong DATA_WIDTH specified for module ham_encoder");
endgenerate
generate if(CALC_CODE_WIDTH != CODE_WIDTH)
	$fatal("Wrong CODE_WIDTH specified for module ham_encoder");
endgenerate

logic parity_bits = 0;
logic [CODE_WIDTH-1] parity_bit_mask = 1;

always_comb begin
	// filling ham_code without parity
	for (int i=1;i<=CODE_WIDTH;i++) begin
		if (i = 2**($clog2(i)) begin
			parity_bits++;
			ham_code[i] = 1'b0;
		end else begin
			ham_code[i] = data[i-parity_bits];
		end
	end
	// calculating parity
	for (int i=1;i<=CODE_WIDTH;i++) begin
		if (i = 2**($clog2(i)) begin
			parity_bits++;
			for (int j=0; j<CODE_WIDTH; j++)
		end
	end
end

endmodule : hamming_encoder
