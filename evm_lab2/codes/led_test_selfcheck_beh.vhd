--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 10.1
--  \   \         Application : ISE
--  /   /         Filename : led_test_selfcheck.vhw
-- /___/   /\     Timestamp : Fri Apr 09 14:17:52 2021
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: led_test_selfcheck_beh
--Device: Xilinx
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY led_test_selfcheck_beh IS
END led_test_selfcheck_beh;

ARCHITECTURE testbench_arch OF led_test_selfcheck_beh IS
    COMPONENT Seven_Segment_Driver
        PORT (
            CLK : In std_logic;
            CLK_DIV : In std_logic;
            Q : In std_logic_vector (15 DownTo 0);
            RST : In std_logic;
            D : Out std_logic_vector (3 DownTo 0);
            A : Out std_logic_vector (3 DownTo 0)
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL CLK_DIV : std_logic := '0';
    SIGNAL Q : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL RST : std_logic := '0';
    SIGNAL D : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL A : std_logic_vector (3 DownTo 0) := "UUUU";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : Seven_Segment_Driver
        PORT MAP (
            CLK => CLK,
            CLK_DIV => CLK_DIV,
            Q => Q,
            RST => RST,
            D => D,
            A => A
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            PROCEDURE CHECK_A(
                next_A : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (A /= next_A) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns A="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, A);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_A);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_D(
                next_D : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (D /= next_D) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns D="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, D);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_D);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                RST <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  215ns
                WAIT FOR 115 ns;
                CHECK_A("1110", 215);
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 170 ns;
                Q <= "1101101001001000";
                -- -------------------------------------
                -- -------------  Current Time:  415ns
                WAIT FOR 30 ns;
                CHECK_D("1000", 415);
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 170 ns;
                RST <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  985ns
                WAIT FOR 400 ns;
                CLK_DIV <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1015ns
                WAIT FOR 30 ns;
                CHECK_D("0100", 1015);
                CHECK_A("1101", 1015);
                -- -------------------------------------
                -- -------------  Current Time:  1185ns
                WAIT FOR 170 ns;
                CLK_DIV <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1785ns
                WAIT FOR 600 ns;
                CLK_DIV <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1815ns
                WAIT FOR 30 ns;
                CHECK_D("1010", 1815);
                CHECK_A("1011", 1815);
                -- -------------------------------------
                -- -------------  Current Time:  1985ns
                WAIT FOR 170 ns;
                CLK_DIV <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2585ns
                WAIT FOR 600 ns;
                CLK_DIV <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2615ns
                WAIT FOR 30 ns;
                CHECK_D("1101", 2615);
                CHECK_A("0111", 2615);
                -- -------------------------------------
                -- -------------  Current Time:  2785ns
                WAIT FOR 170 ns;
                CLK_DIV <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3385ns
                WAIT FOR 600 ns;
                CLK_DIV <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3415ns
                WAIT FOR 30 ns;
                CHECK_D("1000", 3415);
                CHECK_A("1110", 3415);
                -- -------------------------------------
                -- -------------  Current Time:  3585ns
                WAIT FOR 170 ns;
                CLK_DIV <= '0';
                -- -------------------------------------
                WAIT FOR 6615 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

