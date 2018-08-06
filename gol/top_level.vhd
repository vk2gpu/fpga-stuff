library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;

---------------------------------------------------
-- Top level entity
---------------------------------------------------
entity top_level is
	port (
		i_clk : in std_logic;
		i_reset : in std_logic;
		
		o_status : out std_logic;
		o_tick : out std_logic;
		
		o_rows : out std_logic_vector(7 downto 0);
		o_cols : out std_logic_vector(7 downto 0)
	);
end top_level;

---------------------------------------------------
-- Top level entity architecture
---------------------------------------------------
architecture rtl of top_level is
	signal s_sim_clk			: std_logic := '0';
	signal s_sim_out			: std_logic_vector(63 downto 0);
	
	component gol
		port (
			i_clk : in std_logic;
			i_reset : in std_logic;
			i_vals : in std_logic_vector(63 downto 0);
			o_vals : out std_logic_vector(63 downto 0)
		);
	end component;

	component led_driver
		port (
			i_clk : in std_logic;
			
			i_data : in std_logic_vector(63 downto 0);
			o_rows : out std_logic_vector(7 downto 0);
			o_cols : out std_logic_vector(7 downto 0)
		);
	end component;
	

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
	gol_comp: gol port map (
		i_clk => s_sim_clk,
		i_reset => not i_reset,
		i_vals => "0000000000000000000000000000000000000000111000000010000001000000",
		o_vals => s_sim_out
	);
	
	-- 
	led_driver_comp: led_driver port map(
		i_clk => i_clk,
		i_data => s_sim_out,
		o_cols => o_cols,
		o_rows => o_rows
	);
	
	sim_clk_comp: clock_divider
		generic map(
			count => (25000000 / 16)
		)
		port map(
			i_clk => i_clk,
			i_reset => '0',
			o_clk => s_sim_clk
		);

	o_tick <= s_sim_clk ;
end rtl;
