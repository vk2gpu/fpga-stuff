library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

---------------------------------------------------
-- Clock divider entity
---------------------------------------------------
entity clock_divider is
	generic (
		count : integer := 1
	);
	port (
		i_clk : in std_logic;
		i_reset : in std_logic;
		o_clk : out std_logic
	);
end clock_divider;

---------------------------------------------------
-- Clock divider architecture
---------------------------------------------------
architecture rtl of clock_divider is
	signal s_clk_count	: natural range 0 to (count - 1) := 0;
	signal s_clk			: std_logic := '0';
	
begin
	process(i_clk, i_reset) is
	begin
		if rising_edge(i_clk) then
			if i_reset = '1' then
				s_clk_count <= 0;
			else
				if s_clk_count = (count - 1) then
					s_clk <= not s_clk;
					s_clk_count <= 0;
				else
					s_clk_count <= s_clk_count + 1;
				end if;
			end if;
		end if;
	end process;

	o_clk <= s_clk;
end rtl;
