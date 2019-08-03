library ieee;
use ieee.std_logic_1164.all;

entity mult_tb is
end mult_tb;

architecture bhv of mult_tb is

	-- Definizione componente
	component mult is 
		generic(N: natural := 16);
		port(
			a: in std_logic_vector(N-1 downto 0);
			b: in std_logic_vector(N-1 downto 0);
			m: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	-- Dichiarazione costante
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_a: std_logic_vector(N-1 downto 0);
	signal tb_b: std_logic_vector(N-1 downto 0);
	signal tb_m: std_logic_vector(N-1 downto 0);

begin
	
	-- Dichiarazione moltiplicatore
	create: mult 
		generic map(N => N)
		port map(
			a => tb_a,
			b => tb_b,
			m => tb_m
		);

	-- Processo per testare il componente
	process is
	begin
		tb_a <= "0000000000000000"; -- +0
		tb_b <= "0000000110111010"; -- +0.0135000000000000
		wait for 10 ns;
		tb_a <= "0000110011000111"; -- +0.099822998046875 (+0.00134) => out: 0000000000101100(+0.0013)
		tb_b <= "0000000110111010"; 
		wait for 10 ns;
		tb_a <= "0001100101101110"; -- +0.198669433593750 (+0.00268) => out: 0000000001010111(+0.0027)
		tb_b <= "0000000110111010"; 
		wait for 10 ns;
		tb_a <= "0010010111010100"; -- +0.295532226562500 (+0.00391) => out: 0000000010000010(+0.0040)
		tb_b <= "0000000110111010"; 
		wait for 10 ns;
		tb_a <= "0011000111011000"; -- +0.389404296875000 (+0.00513) => out: 0000000010101100(+0.052)
		tb_b <= "0000000110111010"; 
		wait for 10 ns;
		tb_a <= "1000011101111000"; -- -0.058380126953125 (-0.00078) => out: 1000000000011001(-0.007)
		tb_b <= "0000000110111010";
		wait for 10 ns;
	end process;
	

end bhv;
