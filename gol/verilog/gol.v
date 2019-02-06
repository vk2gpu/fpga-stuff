// ---------------------------------------------------
// Game of life
// ---------------------------------------------------
module gol(
	input i_clk,
	input i_reset,
	input [63:0] i_vals,
	output reg [63:0] o_vals
	);

	function integer wrap;
		input integer size;
		input integer x;
		begin
			if(x < 0)
				wrap = size - 1;
			else if(x >= size)
				wrap = 0;
			else 
				wrap = x;
		end
	endfunction

	function integer get_idx;
		input integer size;
		input integer i_x;
		input integer i_y;
		integer x;
		integer y;
		begin
			x = wrap(size, i_x);
			y = wrap(size, i_y);
			get_idx = x + (y * size);
		end
	endfunction

	wire [63:0] s_next_vals;

	reg [7:0] s_reset_delay = 2;

	always @(posedge i_clk) begin
		if(i_reset || s_reset_delay != 0) begin
			o_vals <= i_vals;
			s_reset_delay <= s_reset_delay - 1;
		end else begin		
			o_vals <= s_next_vals;
		end
	end

	genvar i, j;
	generate
		for (j=0; j<8; j=j+1) begin : gen_gol_cell_y
			for (i=0; i<8; i=i+1) begin : gen_gol_cell_x
				gol_cell gol_cell_xy (
					.i_clk(i_clk),
					.i_reset(i_reset || s_reset_delay != 0),
					.i_val(i_vals[get_idx(8, i, j)]),
					.i_neighbours(
						{
							s_next_vals[get_idx(8, i + -1, j + -1)],
							s_next_vals[get_idx(8, i +  0, j + -1)],
							s_next_vals[get_idx(8, i +  1, j + -1)],
							s_next_vals[get_idx(8, i + -1, j +  0)],
							s_next_vals[get_idx(8, i +  1, j +  0)],
							s_next_vals[get_idx(8, i + -1, j +  1)],
							s_next_vals[get_idx(8, i +  0, j +  1)],
							s_next_vals[get_idx(8, i +  1, j +  1)]
						}),
					.o_val(s_next_vals[get_idx(8, i, j)])
				);
			end
		end
	endgenerate
endmodule
