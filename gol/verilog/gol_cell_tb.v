module gol_cell_tb;
	reg i_clk, i_reset; 
	reg i_val;
 	reg [7:0] i_neighbours; 
 	wire o_val;

 	gol_cell gol_cell_inst(
		.i_clk(i_clk),
		.i_reset(i_reset),
		.i_val(i_val),
		.i_neighbours(i_neighbours),
		.o_val(o_val)
	);

 	initial begin
		$dumpfile ("gol_cell_tb.vcd"); 
		$dumpvars; 
 	end

	initial begin
		i_clk = 0;
		i_reset = 0;
		i_neighbours = 8'b11100000;
		i_val = 0;
		$display("\t\ttime,\tclk,\treset,\ti_val,\ti_neighbours,\to_val"); 
		$monitor("%d,\t%b,\t%b,\t%b,\t%8b,\t%b",$time, i_clk,i_reset,i_val,i_neighbours,o_val);

		#4 i_reset = 1;
		#9 i_reset = 0;

		#20 i_neighbours = 8'b10000000;
	end

 	always
		#5 i_clk = ~i_clk;

	initial 
 		#100  $finish;  

endmodule
