library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

---------------------------------------------------
-- LED driver entity
---------------------------------------------------
entity led_driver is
	port (
		i_clk : in std_logic;
			
		i_data : in std_logic_vector(63 downto 0);
		o_rows : out std_logic_vector(7 downto 0);
		o_cols : out std_logic_vector(7 downto 0)
	);
end led_driver;

---------------------------------------------------
-- LED driver entity architecture
---------------------------------------------------
architecture rtl of led_driver is
	signal s_row_clk			: std_logic := '0';
	signal s_row_idx			: natural range 0 to 7 := 0;
	signal s_row_data			: std_logic_vector(7 downto 0);
	signal s_row8				: natural range 0 to (7*8);
	signal s_row_sel			: unsigned(7 downto 0);

	component clock_divider is
		generic (
			count : integer
		);
		port (
			i_clk : in std_logic;
			i_reset : in std_logic;
			o_clk : out std_logic
		);
	end component;	

begin
	row_clock_comp: clock_divider
		generic map(
			count => (25000000 / (120 * 8))
		)
		port map(
			i_clk => i_clk,
			i_reset => '0',
			o_clk => s_row_clk
		);

	process(s_row_clk, i_data) is
	begin
		if rising_edge(s_row_clk) then
			-- Copy in row.
			s_row8 <= s_row_idx * 8;
			s_row_data <= i_data((s_row8 + 7) downto s_row8);
			
			s_row_sel <= shift_left(to_unsigned(1, s_row_sel'length), s_row_idx);
			o_rows <= s_row_data;
			o_cols <= not std_logic_vector(s_row_sel);
			
			-- Next row.
			if s_row_idx < 7 then
				s_row_idx <= s_row_idx + 1;
			else
				s_row_idx <= 0;
			end if;
		end if;
	end process;
end rtl;
