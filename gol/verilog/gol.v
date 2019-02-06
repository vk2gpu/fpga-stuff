// ---------------------------------------------------
// Game of life
// ---------------------------------------------------
module gol(
	input i_clk,
	input i_reset,
	input [63:0] i_vals,
	output [63:0] o_vals
	);

	function integer get_idx;
		input integer size;
		input integer i_i;
		input integer i_x;
		input integer i_y;
		integer x;
		integer y;
		begin
			x = (i_i % size) + i_x;
			y = (i_i / size) + i_y;
			
			if(x < 0) begin
				x = size - 1;
			end
			if(x >= size) begin
				x = 0;
			end

			if(y < 0) begin
				y = size - 1;
			end
			if(y >= size) begin
				y = 0;
			end
			get_idx = x + (y * size);
		end
	endfunction

	wire [63:0] s_vals;

	assign o_vals = s_vals;

	genvar i;
	generate
		for (i=0; i<64; i=i+1) begin : gen_gol_cell_xy
		gol_cell gol_cell_xy (
			.i_clk(i_clk),
			.i_reset(i_reset),
			.i_val(i_vals[i]),
			.i_neighbours(
				{
					s_vals[get_idx(8, i, -1, -1)],
					s_vals[get_idx(8, i, 0, -1)],
					s_vals[get_idx(8, i, 1, -1)],
					s_vals[get_idx(8, i, -1, 0)],
					s_vals[get_idx(8, i, 1, 0)],
					s_vals[get_idx(8, i, -1, 1)],
					s_vals[get_idx(8, i, 0, 1)],
					s_vals[get_idx(8, i, 1, 1)]
				}),
			.o_val(s_vals[i])
		);
	end
	endgenerate
endmodule
