// ---------------------------------------------------
// Game of life cell
// ---------------------------------------------------
module gol_cell (
    input i_clk,
    input i_reset,
    input i_val,
    input [7:0] i_neighbours,
    output reg o_val
);
	integer v_neighbours;
	integer i;

	always @(posedge i_clk) begin
		if(i_reset) begin
			o_val <= i_val;
		end else begin
			v_neighbours <= 0;
			for(i = 0; i < 7; i=i+1) begin
				if (i_neighbours[i]) begin
					v_neighbours <= v_neighbours + 1;
				end
			end
			
			if(v_neighbours == 3) begin
				o_val <= 1;
			end else begin 
				if (v_neighbours < 2 || v_neighbours > 3) begin
					o_val <= 0;
				end
			end
		end
	end
endmodule
