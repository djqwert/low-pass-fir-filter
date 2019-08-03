library ieee;
use ieee.std_logic_1164.all;

entity firfilter is
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
end firfilter;

architecture bhv of firfilter is

	-- Definizione componenti
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
	
	component adder is
		generic(N: natural := 16);
		port(
			m1, m2, m3, m4, m5, m6, m7: in std_logic_vector(N-1 downto 0);
			s: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
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
	
	-- Definizione segnali
	signal df1, df2, df3, df4, df5, df6, df7: std_logic_vector(N-1 downto 0);
	signal dm1, dm2, dm3, dm4, dm5, dm6, dm7: std_logic_vector(N-1 downto 0);
	signal s: std_logic_vector(N-1 downto 0);

begin

	-- Dichiarazione componenti e collegamento
	tap1: tap generic map(N => N) port map(x, c0, df1, dm1, clk, rst, en);
	tap2: tap generic map(N => N) port map(df1, c1, df2, dm2, clk, rst, en);
	tap3: tap generic map(N => N) port map(df2, c2, df3, dm3, clk, rst, en);
	tap4: tap generic map(N => N) port map(df3, c3, df4, dm4, clk, rst, en);
	tap5: tap generic map(N => N) port map(df4, c4, df5, dm5, clk, rst, en);
	tap6: tap generic map(N => N) port map(df5, c5, df6, dm6, clk, rst, en);
	tap7: tap generic map(N => N) port map(df6, c6, df7, dm7, clk, rst, en);
	
	add: adder generic map(N => N) port map(dm1, dm2, dm3, dm4, dm5, dm6, dm7, s);
	
	-- Registro di uscita
	output: reg generic map(N => N)
		port map(
			d => s,
			q => y,
			clk => clk,
			rst => rst,
			en => en
		);
	
	test <= df7; -- Uscita di test, per confermare l'attraverso di tutte le tap degli xi valori in ingresso al filtro

end bhv;