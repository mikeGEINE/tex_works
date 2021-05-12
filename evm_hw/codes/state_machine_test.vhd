--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:28:15 05/10/2021
-- Design Name:   
-- Module Name:   /home/mike_geine/ISE/homework/state_machine_test.vhd
-- Project Name:  homework
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: state_machine
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY state_machine_test IS
END state_machine_test;
 
ARCHITECTURE behavior OF state_machine_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT state_machine
    PORT(
         c : IN  std_logic_vector(6 downto 1);
         clk : IN  std_logic;
         rst : IN  std_logic;
         m : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal c : std_logic_vector(6 downto 1) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal m : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: state_machine PORT MAP (
          c => c,
          clk => clk,
          rst => rst,
          m => m
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst<='1';
		wait for 100 ns;	
		rst<='0';
      --wait for clk_period*10;

      -- insert stimulus here 
		c<="000101";			--AC
		wait for clk_period;
		
		c<="010000";			--E_F
		wait for clk_period;
		
		c<="010000";			--E_F
		wait for clk_period;
		
		c<="000001";			--A_C
		wait for clk_period;
		
		c<="000010";			--B
		wait for clk_period;
		
		c<="000000";			--_B
		wait for clk_period;
		
		c<="010000";			--E_F
		wait for clk_period;
		
		c<="001000";			--D_B
		wait for clk_period;
		
		c<="001000";			--D_B
		wait for clk_period;
		
		c<="101000";			--DF
		wait for clk_period;
		
		c<="001100";			--CD
		wait for clk_period;
		
		c<="001100";			--CD
		wait for clk_period;
		
		c<="000100";			--C_D
		wait for clk_period;
		
		c<="101000";			--DF
		wait for clk_period;
		
		c<="000000";			--_A_C
		wait for clk_period;
		
		c<="000001";			--A_C
		wait for clk_period;
		
		c<="000100";			--_AC
		wait for clk_period;
		
		c<="000101";			--AC
		wait for clk_period;
		
		c<="011000";			--DE
		wait for clk_period;
		
		c<="101000";			--DF
		wait for clk_period;
		
		c<="000101";			--AC
      wait;
   end process;
--test
END;
