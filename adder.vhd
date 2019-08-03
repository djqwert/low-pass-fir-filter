library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is 
	generic(N: integer := 16);
	port(
		m1, m2, m3, m4, m5, m6, m7: in std_logic_vector(N-1 downto 0);
		s: out std_logic_vector(N-1 downto 0)
	);
end adder;

architecture bhv of adder is

	-- Definizione componente
	component ms2c is
		generic(N: integer := 16);
		port(
			x: in std_logic_vector(N-1 downto 0);
			y: out std_logic_vector(N-1 downto 0)
		);
	end component;

	-- Definizione segnali
	signal ar_m1, ar_m2, ar_m3, ar_m4, ar_m5, ar_m6, ar_m7: std_logic_vector(N-1 downto 0);
	signal ar_s1, ar_s2, ar_s3, ar_s4, ar_s5, ar_s6, ar_s7: std_logic_vector(N-1 downto 0);
	signal ar_s : std_logic_vector(N-1 downto 0);

begin

	-- Gli input vengono collegati a segnali che saranno dati in ingresso ai componenti MS2C per effettuare il complemento a 2
	ar_m1 <= m1; ar_m2 <= m2;  ar_m3 <= m3; 
	ar_m4 <= m4; ar_m5 <= m5; ar_m6 <= m6; 
	ar_m7 <= m7;

	-- Dichiarazione componenti e collegamento
	create1: ms2c generic map(N => N) port map(ar_m1, ar_s1);
	create2: ms2c generic map(N => N) port map(ar_m2, ar_s2);
	create3: ms2c generic map(N => N) port map(ar_m3, ar_s3);
	create4: ms2c generic map(N => N) port map(ar_m4, ar_s4);
	create5: ms2c generic map(N => N) port map(ar_m5, ar_s5);
	create6: ms2c generic map(N => N) port map(ar_m6, ar_s6);
	create7: ms2c generic map(N => N) port map(ar_m7, ar_s7);

	ar_s <= std_logic_vector(unsigned(ar_s1) + unsigned(ar_s2) + unsigned(ar_s3) + unsigned(ar_s4) + unsigned(ar_s5) + unsigned(ar_s6) + unsigned(ar_s7));
	
	-- Il risultato della somma viene complementato
	create8: ms2c generic map(N => N) port map(ar_s, s);

end bhv;