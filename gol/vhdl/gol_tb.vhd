library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity gol_tb is
end gol_tb;

architecture behav of gol_tb is
	--  Declaration of the component that will be instantiated.
	component gol
		port(
			i_clk : in std_logic;
			i_reset : in std_logic;
			i_vals : in std_logic_vector(63 downto 0);
			o_vals : out std_logic_vector(63 downto 0)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for gol_0: gol use entity work.gol;

	signal i_clk : std_logic;
	signal i_reset : std_logic;
	signal i_vals : std_logic_vector(63 downto 0);
	signal o_vals : std_logic_vector(63 downto 0);

	function GetIdx(
			size : in integer;
			i_i : in integer;
			i_x : in integer;
			i_y : in integer
		)
		return integer is
		variable x : integer;
		variable y : integer;
	begin
		x := (i_i mod size) + i_x;
		y := (i_i / size) + i_y;
		
		if x < 0 then
			x := size - 1;
		end if;
		if x >= size then
			x := 0;
		end if;
		
		if y < 0 then
			y := size - 1;
		end if;
		if y >= size then
			y := 0;
		end if;
		return x + (y * size);
	end GetIdx;

begin
	--  Component instantiation.
	gol_0: gol port map (
			i_clk => i_clk,
			i_reset => i_reset,
			i_vals => i_vals,
			o_vals => o_vals
		);

	process
		variable l : line;
	begin
		wait for 100 ns;
		
		i_clk <= '0';
		i_vals(63 downto 56) <= "00000000";
		i_vals(55 downto 48) <= "00000000";
		i_vals(47 downto 40) <= "00000000";
		i_vals(39 downto 32) <= "00000000";
		i_vals(31 downto 24) <= "00000000";
		i_vals(23 downto 16) <= "11100000";
		i_vals(15 downto 8)  <= "00100000";
		i_vals(7 downto 0)   <= "01000000";
	--	11100000000000000000000000000000111000000000000000000000";
		i_reset <= '1';

		wait for 1 ns;
		i_clk <= '1';
		wait for 1 ns;
		i_clk <= '0';
		i_reset <= '0';

		for i in 0 to 80 loop
			wait for 1 ns;
			i_clk <= '1';
			wait for 1 ns;
			i_clk <= '0';
			
			
			for y in 7 downto 0 loop
				for x in 7 downto 0 loop
					write(l, o_vals(x + (y * 8)));
				end loop;
				writeline(output, l);
			end loop;
			
			write(l, String'("======================="));
			writeline(output, l);
		end loop;

		report "end of test" severity note;
		wait;
	end process;
end behav;
