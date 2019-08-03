library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tap is 
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
end tap;

architecture bhv of tap is

	-- Definizione componenti
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

	component mult is 
		generic(N: natural := 16);
		port(
			a: in std_logic_vector(N-1 downto 0);
			b: in std_logic_vector(N-1 downto 0);
			m: out std_logic_vector(N-1 downto 0)
		);
	end component;

begin

	-- Registro dove memorizzare il dato da trasmettere alla tap successiva
	create_dffn: reg
		generic map(N => N)
		port map(
			d => x,
			q => qf,
			clk => clk,
			rst => rst,
			en => en
		);
	
	-- Moltiplicatore x*c
	create_mul: mult
		generic map(N => N)
		port map(
			a => x,
			b => c,
			m => qm
		);

end bhv;