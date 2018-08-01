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
	constant c_CNT_1HZ		: natural := 25000000;
	constant c_SIM_CNT		: natural := c_CNT_1HZ / 2;

	signal r_sim_count		: natural range 0 to c_SIM_CNT;
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
	
begin
	gol_sim: gol port map (
		i_clk => s_sim_clk,
		i_reset => i_reset,
		i_vals => "0000000011100000000000000000000000000000111000000000000000000000",
		o_vals => s_sim_out
	);
	
	o_status <= i_reset;
	o_rows <= "10101010";
	o_cols <= "10101010";
	
	process(i_clk, s_sim_clk, r_sim_count) is
	begin
		if r_sim_count = (c_SIM_CNT - 1) then
			o_tick <= not s_sim_clk;
			s_sim_clk <= not s_sim_clk;
			r_sim_count <= 0;
		else
			r_sim_count <= r_sim_count + 1;
		end if;
	end process;

end rtl;
