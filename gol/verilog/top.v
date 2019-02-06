module top(
    input i_clk,
    output o_tick,
    output [7:0] o_rows,
    output [7:0] o_cols
);
    wire s_sim_clk;
    wire [63:0] s_sim_out;

    // Reset on start up.
    reg s_reset = 0;
    reg [5:0] s_reset_cnt = 0;
    wire s_nreset = &s_reset_cnt;
    always @(posedge i_clk) begin
        s_reset_cnt = s_reset_cnt + !s_nreset;
        s_reset = !s_nreset;
    end
    
    gol gol_inst(
            .i_clk(s_sim_clk),
            .i_reset(s_reset),
            .i_vals(64'b0000000000000000000000000000000000000000111000000010000001000000),
            .o_vals(s_sim_out)
        );

    led_driver led_driver_inst(
            .i_clk(i_clk),
            .i_reset(s_reset),
            .i_data(s_sim_out),
            .o_cols(o_cols),
            .o_rows(o_rows)
        );

    clock_divider clock_divider_inst(
            .i_clk(i_clk),
            .i_reset(s_reset),
            .i_count(8000000 / 8),
            .o_clk(s_sim_clk)
        );

    assign o_tick = s_sim_clk;
endmodule
