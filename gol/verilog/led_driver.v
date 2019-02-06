// -------------------------------------------------
//  LED driver entity
// -------------------------------------------------
module led_driver(
	input i_clk,
	input i_reset,
	input [63:0] i_data,
	output reg [7:0] o_rows,
	output reg [7:0] o_cols
);
	wire s_row_clk;
	reg [3:0] s_row_idx = 0;
	reg [7:0] s_row_data = 0;
	reg [7:0] s_row_sel = 0;
	integer s_row8;
	integer i = 0;

	clock_divider clock_divider_inst(
			.i_clk(i_clk),
			.i_reset(i_reset),
			.i_count(8000000 / (60 * 8)),
			.o_clk(s_row_clk)
		);

	always @(posedge s_row_clk) begin
		s_row8 = s_row_idx * 8;
	    for(i = 0; i < 8; i=i+1)
			s_row_data[i] <= i_data[(s_row8 + 7) - i];
		s_row_sel = 1 << s_row_idx;

		o_rows <= s_row_data;
		o_cols <= ~s_row_sel;

		if(s_row_idx < 7) begin
			s_row_idx = s_row_idx + 1;			
		end else begin
			s_row_idx = 0;
		end
	end
endmodule
