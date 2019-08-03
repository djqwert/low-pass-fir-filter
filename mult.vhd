library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is 
	generic(N: natural := 16);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		m: out std_logic_vector(N-1 downto 0)
	);
end mult;

architecture bhv of mult is

	-- Definizione segnali
	signal ar_a: std_logic_vector(N-1 downto 0);
	signal ar_b: std_logic_vector(N-1 downto 0);
	signal ar_mult: std_logic_vector(N+N-1 downto 0);

begin
	
	-- Assegno gli input ai segnali. Nei segnali rimpiazzo il bit di segno in modo da fare un prodotto modulo-modulo 
	ar_a(N-1) <= '0';
	ar_a(N-2 downto 0) <= a(N-2 downto 0);
	ar_b(N-1) <= '0';
	ar_b(N-2 downto 0) <= b(N-2 downto 0);
	
	ar_mult <= std_logic_vector(unsigned(ar_a) * unsigned(ar_b));
	
	m(N-2 downto 0) <= ar_mult(2*N-3 downto N-1); -- Scarto il bit di segno e di ow (29 downto 15)
	m(N-1) <= a(N-1) xor b(N-1); -- Recupero il bit di segno

end bhv;