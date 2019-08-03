library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tap_tb is
end tap_tb;

architecture bhv of tap_tb is

	-- Definizione componente
	component tap is 
		generic(N: natural := 16);
		port(
			x: in std_logic_vector(N-1 downto 0);
			c: in std_logic_vector(N-1 downto 0);
			qf: out std_logic_vector(N-1 downto 0);
			qm: out std_logic_vector(N-1 downto 0);
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic
		);
	end component;
	
	-- Dichiarazione costanti
	constant T_clk: time := 10 ns;
	constant T_sim: time := 100 ns;
	constant T_rst: time := 10 ns;
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_x: std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(0, N));
	signal tb_c: std_logic_vector(N-1 downto 0) := "0000000110111010"; -- +0.0135000000000000
	signal tb_qf: std_logic_vector(N-1 downto 0);
	signal tb_qm: std_logic_vector(N-1 downto 0);
	
	signal tb_clk: std_logic := '0';
	signal tb_stopSimulation: std_logic := '1';
	signal tb_en, tb_rst: std_logic := '0';

begin

	
	tb_clk <= (not(tb_clk) and tb_stopSimulation) after T_clk/2; -- Il segnale di clock varia il proprio valore ogni t_clk/2 finché tb_stopSimulation è 1
	tb_stopSimulation <= '0' after T_sim; -- Dopo T_sim la simulazione si ferma
	tb_rst <= '1' after T_rst; -- Dopo T_rst, tb_rst passa ad 1

	-- Dichiarazione tap
	create: tap
		generic map(N => N)
		port map(
			x => tb_x,
			c => tb_c,
			qf => tb_qf,
			qm => tb_qm,
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
				
				when 0 => tb_en <= '1';
				when 1 => tb_x <= "0000000000000000"; -- +0
				when 2 => tb_x <= "0000110011000111"; -- +0.099822998046875 => out: 0000000000101100 (+0.0013)
				when 3 => tb_x <= "0001100101101110"; -- +0.198669433593750 => out: 0000000001010111 (+0.0027)
				when 4 => tb_x <= "0010010111010100"; -- +0.295532226562500 => out: 0000000010000010 (+0.0040)
				when 5 => tb_x <= "0011000111011000"; -- +0.389404296875000 => out: 0000000010101100 (+0.0522)
				when 6 => tb_x <= "1000011101111001"; -- -0.058380126953125 => out: 1000000000011001 (-0.0007)
				when others => tb_x <= "0000000000000000";
			end case;
			t := t + 1;
		end if;
	
	end process;

end bhv;