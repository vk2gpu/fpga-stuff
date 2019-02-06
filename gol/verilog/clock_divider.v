// -------------------------------------------------
// Clock divider
// -------------------------------------------------
module clock_divider(
	input i_clk,
	input i_reset,
	input [31:0] i_count,
	output reg o_clk
);
	reg s_clk;
	reg [31:0] s_clk_count = 0;

	always @(posedge i_clk) begin
		if(i_reset) begin
			s_clk_count <= 0;
		end else begin
			if(s_clk_count == (i_count - 1)) begin
				s_clk <= ~s_clk;
				s_clk_count <= 0;
			end else begin
				s_clk_count <= s_clk_count + 1;
			end
		end
		o_clk <= s_clk;
	end
endmodule
