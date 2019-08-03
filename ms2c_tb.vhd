library ieee;
use ieee.std_logic_1164.all;

entity ms2c_tb is
end ms2c_tb;

architecture bhv of ms2c_tb is

	-- Definizione componente
	component ms2c is
		generic(N: integer := 16);
		port(
			x: in std_logic_vector(N-1 downto 0);
			y: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	-- Dichiarazione costante
	constant N: natural := 16;
	
	-- Definizione segnali
	signal tb_x: std_logic_vector(N-1 downto 0) := "0000000000000000";
	signal tb_y: std_logic_vector(N-1 downto 0);

begin

	-- Dichiarazione del componente
	create: ms2c
		generic map(N => N)
		port map(
			x => tb_x,
			y => tb_y
		);

	-- Processo per testare il componente
	process is
	begin
		tb_x <= "0000000000000001"; wait for 10 ns;
		tb_x <= "1111111111111111"; wait for 10 ns;
	end process;

end bhv;