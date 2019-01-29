library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

---------------------------------------------------
-- Game of life cell
---------------------------------------------------
entity gol_cell is
	port (
		i_clk : in std_logic;
		i_reset : in std_logic;
		i_val : in std_logic;
		i_neighbours : in std_logic_vector(7 downto 0);
		o_val : out std_logic
	);
end gol_cell;

---------------------------------------------------
-- Game of life cell architecture
---------------------------------------------------
architecture rtl of gol_cell is
	signal s_val : std_logic;
begin
	p_clk : process (i_clk, i_reset)
		variable v_neighbours : natural range 0 to 8;
		variable l : line;
	begin
		if rising_edge(i_clk) then
			if i_reset = '1' then
				o_val <= i_val;
			else
				v_neighbours := 0;
				for i in 0 to 7 loop
					if i_neighbours(i) = '1' then
						v_neighbours := v_neighbours + 1;
					end if;
				end loop;
				
				if v_neighbours = 3 then
					o_val <= '1';
				elsif v_neighbours < 2 or v_neighbours > 3 then
					o_val <= '0';
				end if;
			end if;
		end if;
	end process p_clk;
end rtl;
