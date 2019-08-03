library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end adder_tb;

architecture bhv of adder_tb is

	-- Definizione componente
	component adder is
		generic(N: natural := 16);
		port(
			m1, m2, m3, m4, m5, m6, m7: in std_logic_vector(N-1 downto 0);
			s: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	-- Dichiarazione costante
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_m1, tb_m2, tb_m3, tb_m4, tb_m5, tb_m6, tb_m7: std_logic_vector(N-1 downto 0) := "0000000000000000";
	signal tb_s: std_logic_vector(N-1 downto 0) := "0000000000000000";

begin

	-- Dichiarazione sommatore
	create: adder
		generic map(N => N)
		port map(
			m1 => tb_m1,
			m2 => tb_m2,
			m3 => tb_m3,
			m4 => tb_m4,
			m5 => tb_m5,
			m6 => tb_m6,
			m7 => tb_m7,
			s => tb_s
		);

	-- Processo per testare il componente
	process is -- In ingresso vengono dati binari in modulo e segno
	begin
		tb_m1 <= "0000000000000001";
		tb_m2 <= "0000000000000001";
		tb_m3 <= "0000000000000001";
		tb_m4 <= "0000000000000001";
		tb_m5 <= "0000000000000001";
		tb_m6 <= "0000000000000001";
		tb_m7 <= "0000000000000001";
		wait for 100 ns;
		tb_m1 <= "1111111111111110";
		tb_m2 <= "1111111111111110";
		tb_m3 <= "1111111111111110";
		tb_m4 <= "1111111111111110";
		tb_m5 <= "1111111111111110";
		tb_m6 <= "1111111111111110";
		tb_m7 <= "1111111111111110";
		wait for 100 ns;
		tb_m1 <= "0000000000000001";
		tb_m2 <= "0000000000000001";
		tb_m3 <= "0000000000000001";
		tb_m4 <= "0000000000000000";
		tb_m5 <= "1000000000000001";
		tb_m6 <= "1000000000000001";
		tb_m7 <= "1000000000000001";
		wait for 100 ns;
	end process;

end bhv;