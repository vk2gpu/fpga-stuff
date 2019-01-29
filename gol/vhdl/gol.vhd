library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;

---------------------------------------------------
-- Game of life
---------------------------------------------------
entity gol is
	port (
		i_clk : in std_logic;
		i_reset : in std_logic;
		i_vals : in std_logic_vector(63 downto 0);
		o_vals : out std_logic_vector(63 downto 0)
	);
end gol;

---------------------------------------------------
-- Game of life architecture
---------------------------------------------------
architecture rtl of gol is
	component cell
		port (
			i_clk : in std_logic;
			i_reset : in std_logic;
			i_val : in std_logic;
			i_neighbours : in std_logic_vector(7 downto 0);
			o_val : out std_logic
		);
	end component;

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

	signal s_vals : std_logic_vector(63 downto 0);

begin
	-- Tie signal to output.
	o_vals <= s_vals;

	--  Component instantiation.
	geni: for i in 0 to 63 generate
		for gol_cell_xy : cell use entity work.gol_cell;
	begin

		gol_cell_xy: cell port map (
			i_clk => i_clk,
			i_reset => i_reset,
			i_val => i_vals(i),
			i_neighbours(0) => s_vals(GetIdx(8, i, -1, -1)),
			i_neighbours(1) => s_vals(GetIdx(8, i, 0, -1)),
			i_neighbours(2) => s_vals(GetIdx(8, i, 1, -1)),
			i_neighbours(3) => s_vals(GetIdx(8, i, -1, 0)),
			i_neighbours(4) => s_vals(GetIdx(8, i, 1, 0)),
			i_neighbours(5) => s_vals(GetIdx(8, i, -1, 1)),
			i_neighbours(6) => s_vals(GetIdx(8, i, 0, 1)),
			i_neighbours(7) => s_vals(GetIdx(8, i, 1, 1)),
			o_val => s_vals(i)
		);
	end generate geni;
end rtl;
