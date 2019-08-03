library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_tb is
end reg_tb;

architecture bhv of reg_tb is

	-- Definizione componente
	component reg is 
		generic(N: natural := 16);
		port(
			d: in std_logic_vector(N-1 downto 0);
			q: out std_logic_vector(N-1 downto 0);
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic
		);
	end component;
	
	-- Dichiarazione costanti
	constant T_clk: time := 100 ns;
	constant T_sim: time := 500 ns;
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_clk: std_logic := '0';
	signal tb_stopSimulation: std_logic := '1';
	signal tb_en, tb_rst: std_logic := '0';
	signal tb_d: std_logic_vector(N-1 downto 0):= "0000000000000000";
	signal tb_q: std_logic_vector(N-1 downto 0);

begin

	tb_clk <= (not(tb_clk) and tb_stopSimulation) after T_clk/2; -- Il segnale di clock varia il proprio valore ogni t_clk/2 finché tb_stopSimulation è 1
	tb_stopSimulation <= '0' after T_sim; -- Dopo T_sim la simulazione si ferma
	
	-- Dichiarazione registro
	create: reg
		generic map(N => N)
		port map(
			d => tb_d,
			q => tb_q,
			clk => tb_clk,
			rst => tb_rst,
			en => tb_en
		);
	
	-- Processo per testare il componente
	process(tb_clk)
	variable t: natural := 0;
	begin
		
		if rising_edge(tb_clk) then
			case t is
				
				when 0 => tb_en <= '1'; tb_rst <= '1';
				when 1 to 240 => tb_d <= std_logic_vector(to_unsigned(t, N));
				when others => tb_d <= "0000000000000000";
				
			end case;
			t := t + 1;
		end if;
	
	end process;	

end bhv;