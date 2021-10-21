/****************************************************************
 * tb_ham.sv - testbench for hamming encoder decoder
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 19th October, 2021
 *
 * Description   :
 * -----------
 * input data = 4 bits
 * hamming code = 7 bits
 * output code = 4 bits
 * verify equality manually
 ****************************************************************/

module tb_ham;

// printing env
import "DPI-C" function string getenv(input string env_name);

// inputs to hamming encoder
logic [3:0] data;
logic [6:0] ham_code;
logic [6:0] ham_code_with_noise;
logic [3:0] data_out;
logic [3:0] data_out_from_noise;

// instantiator
ham_encoder encoder(.*);
ham_decoder decoder1(.*);
ham_decoder decoder2(.data_out(data_out_from_noise), .ham_code(ham_code_with_noise));

class packet;
	rand bit [2:0] Noise[];

	constraint arraySize { Noise.size() == 16; };
endclass

packet pkt = new();

logic [6:0] noise;

initial begin
	assert(pkt.randomize()) else $error("Problems generating random numbers");
	#50;
	$display("\nTesting 7,4 hamming code with encoding and decoding");
	$display("Sources: Viraj Khatri (vk5@pdx.edu), pwd=%s\n", getenv("PWD"));
	$display("========================================================================");
	$display(" data -> hamming code -> decoded data");
	$display(" data -> hamming code ^  noise  -> noisy hamming code -> corrected data");
	$display("========================================================================");
	for(int i=0; i<=2**4; i++) begin
		data = i;
		#50;
		noise = 7'b0000001 << pkt.Noise[i];
		ham_code_with_noise = ham_code ^ noise;
		#50;
		$display(" %b ->   %b   -> %b ", data, ham_code, data_out);
		$display(" %b ->   %b   ^  %b ->      %b     ->    %b", data, ham_code, noise, ham_code_with_noise, data_out_from_noise);
		$display("------------------------------------------------------------------------");
	end
	$display("========================================================================");
	$display("Sources: Viraj Khatri (vk5@pdx.edu), pwd=%s\n", getenv("PWD"));
	$display("\nSimulation complete, stopping");
	$display("Author : Viraj Khatri (vk5@pdx.edu)");
	$stop;
end

endmodule : tb_ham
