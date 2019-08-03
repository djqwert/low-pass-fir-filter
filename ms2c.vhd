library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ms2c is 
	generic(N: integer := 16);
	port(
		x: in std_logic_vector(N-1 downto 0);
		y: out std_logic_vector(N-1 downto 0)
	);
end ms2c;

architecture bhv of ms2c is

	-- Definizione segnali
	signal ar_x, ar_y: std_logic_vector(N-1 downto 0);

begin
	
	-- Assegno l'input al segnale
	ar_x <= x;
	
	-- Esegue una XOR sugli N-2 bit meno significativi
	ar_y(N-2) <= x(N-1) xor ar_x(N-2);
	ar_y(N-3) <= x(N-1) xor ar_x(N-3);
	ar_y(N-4) <= x(N-1) xor ar_x(N-4);
	ar_y(N-5) <= x(N-1) xor ar_x(N-5);
	ar_y(N-6) <= x(N-1) xor ar_x(N-6);
	ar_y(N-7) <= x(N-1) xor ar_x(N-7);
	ar_y(N-8) <= x(N-1) xor ar_x(N-8);
	ar_y(N-9) <= x(N-1) xor ar_x(N-9);
	ar_y(N-10) <= x(N-1) xor ar_x(N-10);
	ar_y(N-11) <= x(N-1) xor ar_x(N-11);
	ar_y(N-12) <= x(N-1) xor ar_x(N-12);
	ar_y(N-13) <= x(N-1) xor ar_x(N-13);
	ar_y(N-14) <= x(N-1) xor ar_x(N-14);
	ar_y(N-15) <= x(N-1) xor ar_x(N-15);
	ar_y(N-16) <= x(N-1) xor ar_x(N-16);
	
	-- L'uscita y sarà pari ad x se questo è positivo, altrimenti ad ar_y se x è negativo
	y(N-2 downto 0) <= ar_y(N-2 downto 0) when (x(N-1) = '0') else std_logic_vector(unsigned(ar_y(N-2 downto 0)) + to_unsigned(1,15));
	
	y(N-1) <= x(N-1);
	
end bhv;