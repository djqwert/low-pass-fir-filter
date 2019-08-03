library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity firfilter_tb is
end firfilter_tb;

architecture bhv of firfilter_tb is

	-- Definizione componente
	component firfilter is
		generic(
			N: natural := 16
		);
		port(
			test: out std_logic_vector(N-1 downto 0);
			x: in std_logic_vector(N-1 downto 0);
			c0, c1, c2, c3, c4, c5, c6: in std_logic_vector(N-1 downto 0);
			y: out std_logic_vector(N-1 downto 0);
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic
		);
	end component;
	
	-- Dichiarazione costante
	constant T_clk: time := 100 ns;
	constant T_sim: time := 10000 ns;
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_x: std_logic_vector(N-1 downto 0) := "0000000000000000";
	signal tb_c0: std_logic_vector(N-1 downto 0) := "0000000110111010"; -- 0.0135000000000000
	signal tb_c1: std_logic_vector(N-1 downto 0) := "0000101000001100"; -- 0.0785000000000000
	signal tb_c2: std_logic_vector(N-1 downto 0) := "0001111011010110"; -- 0.2409000000000000
	signal tb_c3: std_logic_vector(N-1 downto 0) := "0010101011001110"; -- 0.3344000000000000
	signal tb_c4: std_logic_vector(N-1 downto 0) := "0001111011010110"; -- 0.2409000000000000
	signal tb_c5: std_logic_vector(N-1 downto 0) := "0000101000001100"; -- 0.0785000000000000
	signal tb_c6: std_logic_vector(N-1 downto 0) := "0000000110111010"; -- 0.0135000000000000
	signal tb_test, tb_y: std_logic_vector(N-1 downto 0);
	
	signal tb_clk: std_logic := '0';
	signal tb_stopSimulation: std_logic := '1';
	signal tb_en, tb_rst: std_logic := '0';

begin

	tb_clk <= (not(tb_clk) and tb_stopSimulation) after T_clk/2; -- Il segnale di clock varia il proprio valore ogni t_clk/2 finché tb_stopSimulation è 1
	tb_stopSimulation <= '0' after T_sim; -- Dopo T_sim la simulazione si ferma

	-- Dichiarazione filtro
	create: firfilter
		generic map(N => N)
		port map(
			test => tb_test,
			x => tb_x,
			c0 => tb_c0,
			c1 => tb_c1,
			c2 => tb_c2,
			c3 => tb_c3,
			c4 => tb_c4,
			c5 => tb_c5,
			c6 => tb_c6,
			y => tb_y,
			clk => tb_clk,
			rst => tb_rst,
			en => tb_en
		);
	
	-- Processo per testare il componente. I singoli test sono spiegati nella documentazione
	process(tb_clk)
	variable t: natural := 0;
	begin
		
		if rising_edge(tb_clk) then
			case t is
				when 0 => tb_en <= '1'; tb_rst <= '1'; tb_x <= "0000000000000000";
				
				-- test 1 [convoluzione di 0.1]
				when 1 => tb_x <= "0000110011001101";
				
				-- test 2 [convoluzione di 0 0.0998229980468750	0.198669433593750 0.295532226562500 0.389404296875000 0.479431152343750	0.564636230468750]
				--when 1 => tb_x <= "0000000000000000";
				--when 2 => tb_x <= "0000110011000111";
				--when 3 => tb_x <= "0001100101101110";
				--when 4 => tb_x <= "0010010111010100";
				--when 5 => tb_x <= "0011000111011000";
				--when 6 => tb_x <= "0011110101011110";
				--when 7 => tb_x <= "0100100001000110";
				
				-- test 3
				--when 1 => tb_x <= "0111111111110010";
				--when 2 => tb_x <= "0111111011101111";
				--when 3 => tb_x <= "0111110010100111";
				--when 4 => tb_x <= "0111100100100000";
				--when 5 => tb_x <= "0111010001100100";
				--when 6 => tb_x <= "0110111001111110";
				--when 7 => tb_x <= "0110011101111101";
	
				-- test 4
				--when 1 => tb_x <= "1000011101111001";
				--when 2 => tb_x <= "1001010000110001";
				--when 3 => tb_x <= "1010000010110110";
				--when 4 => tb_x <= "1010110011100110";
				--when 5 => tb_x <= "1011100010100101";
				--when 6 => tb_x <= "1100001111010010";
				--when 7 => tb_x <= "1100111001010001";
				
				-- test 5
				--when 1 => tb_x <= "0001111010100000";
				--when 2 => tb_x <= "0001001000010000";
				--when 3 => tb_x <= "0000010101010011";
				--when 4 => tb_x <= "1000011101111001";
				--when 5 => tb_x <= "1001010000110001";
				--when 6 => tb_x <= "1010000010110110";
				--when 7 => tb_x <= "1010110011100110";
				--
				
				when others => tb_x <= "0000000000000000";
			end case;
			t := t + 1;
		end if;
	
	end process;

end bhv;