library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity gol_cell_tb is
end gol_cell_tb;

architecture behav of gol_cell_tb is
	--  Declaration of the component that will be instantiated.
	component gol_cell
		port(
			i_clk : in std_logic;
			i_reset : in std_logic;
			i_val : in std_logic;
			i_neighbours : in std_logic_vector(7 downto 0);
			o_val : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the component.
	for gol_cell_0: gol_cell use entity work.gol_cell;

	signal i_clk : std_logic;
	signal i_reset : std_logic;
	signal i_val : std_logic;
	signal i_neighbours : std_logic_vector(7 downto 0);
	signal o_val : std_logic;

begin
	--  Component instantiation.
	gol_cell_0: gol_cell port map (
			i_clk => i_clk,
			i_reset => i_reset,
			i_val => i_val,
			i_neighbours => i_neighbours,
			o_val => o_val
		);

	process
		variable l : line;
	begin
		wait for 100 ns;
		
		i_clk <= '0';
		i_val <= '0';
		i_reset <= '1';

		wait for 1 ns;
		i_clk <= '1';
		i_reset <= '0';
		
		wait for 1 ns;
		assert o_val = '0'
			report "bad output value" severity error;
		
		i_neighbours <= "11100000";
		wait for 1 us;
		i_clk <= '1';

		wait for 1 ns;
		assert o_val = '1'
			report "bad output value" severity error;
		
		
		i_clk <= '0';
		i_reset <= '0';

		write(l, i_neighbours);
		writeline(output, l);
		write(l, i_val);
		writeline(output, l);
		write(l, o_val);
		writeline(output, l);

		report "end of test" severity note;
		wait;
	end process;
end behav;
