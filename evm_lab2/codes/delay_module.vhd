library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity delay_module is
	 PORT (
		 RST: IN STD_LOGIC;
		 CLK: IN STD_LOGIC;
		 COUNT: IN STD_LOGIC;
		 CNT: OUT STD_LOGIC
	 );
end delay_module;

architecture Behavioral of delay_module is
	--      
	CONSTANT STATE0: STD_LOGIC_VECTOR (1 downto 0) := "00";
	CONSTANT STATE1: STD_LOGIC_VECTOR (1 downto 0) := "10";
	CONSTANT STATE2: STD_LOGIC_VECTOR (1 downto 0) := "11";
	CONSTANT STATE3: STD_LOGIC_VECTOR (1 downto 0) := "01";
	--      t
	SIGNAL S: STD_LOGIC_VECTOR (1 downto 0);
	--      t+1
	SIGNAL SN: STD_LOGIC_VECTOR (1 downto 0);
	--  2^20
	SIGNAL COUNTER: INTEGER;
	--  " "
	SIGNAL DLY_OVF: STD_LOGIC;
	 --    
	 SIGNAL DLY_EN: STD_LOGIC;
begin
	--  
	FSM_STATE_inst: PROCESS (CLK)
	BEGIN
	IF (CLK='1' and CLK'event) THEN
	IF (RST='1') THEN
	S <= STATE0;
	ELSE
	S <= SN;
	END IF;
	END IF;
	END PROCESS;
	--      CNT  DLY_EN (  )
	CNT <= S(1);
	DLY_EN <= S(0) xor S(1);
	--      (  )
	SN(0) <= (S(1)and S(0)) or (DLY_OVF and S(1)) or ( (not DLY_OVF) and S(0));
	SN(1) <= (S(1) and (not S(0))) or (COUNT and S(1)) or (COUNT and (not S(0)));
	--  
	COUNTER_inst: PROCESS (CLK)
	BEGIN
		IF (CLK='1' and CLK'event) THEN
			IF (RST='1' or DLY_EN = '0') THEN
				COUNTER <= 0;
			ELSE
				COUNTER <= COUNTER + 1;
			END IF;
		END IF;
	END PROCESS;
	DLY_OVF <= '1' WHEN COUNTER = 2**24-1 ELSE '0';
end Behavioral;

