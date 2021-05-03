library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_decode is
    Port ( 	DH : 		in  	STD_LOGIC_VECTOR (3 downto 0);
           	SEG_DATA : 	out  	STD_LOGIC_VECTOR (7 downto 0));
end led_decode;
architecture Behavioral of led_decode is
begin
process (DH) 
begin
	case DH is
		when "0000" => SEG_DATA <= "10000001";
		when "0001" => SEG_DATA <= "11001111";
		when "0010" => SEG_DATA <= "10010010";
		when "0011" => SEG_DATA <= "10000110";
		when "0100" => SEG_DATA <= "11001100";
		when "0101" => SEG_DATA <= "10100100";
		when "0110" => SEG_DATA <= "10100000";
		when "0111" => SEG_DATA <= "10001111";
		when "1000" => SEG_DATA <= "10000000";
		when "1001" => SEG_DATA <= "10000100";
		when "1010" => SEG_DATA <= "10001000";
		when "1011" => SEG_DATA <= "11100000";
		when "1100" => SEG_DATA <= "10110001";
		when "1101" => SEG_DATA <= "11000010";
		when "1110" => SEG_DATA <= "10110000";
		when "1111" => SEG_DATA <= "10111000";
		when others => null;
	end case;
end process;
end Behavioral;
