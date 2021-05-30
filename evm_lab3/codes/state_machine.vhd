----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:21 05/09/2021 
-- Design Name: 
-- Module Name:    state_machine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machine is
PORT(	c : IN std_logic_vector ( 6 DOWNTO 1 );
		 clk : IN std_logic;
		 rst : IN std_logic;
		 m : OUT std_logic_vector ( 7 DOWNTO 0 ) );
end state_machine;

architecture Behavioral of state_machine is
	TYPE STATE_TYPE IS (s1, s2, s3, s4, s5, s6);
	SIGNAL current_state, next_state : STATE_TYPE;
begin
	clocked_proc: PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			IF (rst='1') THEN
			current_state <= s1;
			ELSE
			current_state <= next_state;
			END IF;
		END IF;
	END PROCESS clocked_proc;
	
	comb_proc : PROCESS (current_state,C)
	BEGIN
		CASE current_state IS
		when s1=>
			m <= (2 =>'1', others => '0');
			if (c(5)='1' and c(6)='0') then
				next_state<=s2;
			elsif (c(3)='1' and c(4)='1') then
				next_state<=s4;
			elsif (c(1)='0' and c(3)='0') then
				next_state<=s6;
			else
				next_state<=s1;
			end if;
		when s2 =>
			m<=(0=>'1', others=>'0');
			if (c(1)='1' and c(3)='0') then
				next_state<=s3;
			elsif (c(4)='1' and c(2)='0') then
				next_state<=s5;
			else
				next_state<=s2;
			end if;
		when s3=>
			m<=(1=>'1',7=>'1',others=>'0');
			if (c(2)='0') then
				m(4)<='1';
				next_state<=s1;
			else
				next_state<=s3;
			end if;
		when s4 =>
			m<=(5=>'1',6=>'1', others=>'0');
			if (c(3)='1' and c(4)='0') then
				m(5)<='1';
				m(6)<='1';
				next_state<=s5;
			else
				next_state<=s4;
			end if;
		when s5 =>
			m<=(3=>'1', others=>'0');
			if (c(4)='1' and c(6)='1') then
				next_state<=s1;
			else
				m(5)<='1';
				m(7)<='1';
			end if;
		when s6 =>
			m<=(4=>'1', others=>'0');
			if (c(1)='1' or c(3)='1') then
				next_state<=s6;
			else
				next_state<=s5;
			end if;
		when others =>
			next_state <= s1;
		end case;
	end process comb_proc;
end Behavioral;

