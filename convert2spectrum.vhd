-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : convert fft data into spectrum magnitude bins						*
-- *************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY convert2spectrum IS
	PORT(
		-- R is real and I is imaginary
		X0R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
		X0I: IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
		X1R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
		X1I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
		X2R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
		X2I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X3R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X3I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X4R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X4I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X5R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X5I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X6R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X6I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X7R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X7I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X8R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X8I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X9R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X9I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X10R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X10I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X11R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X11I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X12R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X12I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X13R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X13I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X14R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X14I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X15R : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X15I : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	
		V0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V5 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V6 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V7 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V8 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V9 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V10 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V11 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V12 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V13 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V14 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		V15 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		
		next_bin_set : OUT STD_LOGIC := '0'; -- signal receiving end new bin set data available.
		incoming128sets : IN STD_LOGIC := '0'; -- 128 sets of 16 sample incoming (signaled by next out from fft)
		fft_finished : OUT STD_LOGIC := '0'; -- The fft data has left the process
		clk_in : IN STD_LOGIC := '0';
		
		converting : OUT STD_LOGIC := '0');	-- to stop the clock of fft and input shifter
END convert2spectrum;


ARCHITECTURE convert of convert2spectrum IS
	VARIABLE convert : STD_LOGIC := '0';
	VARIABLE step : INTEGER := 0;
	VARIABLE count_fft : INTEGER := 0;
	
	SIGNAL sub_wire_0 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_1 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_2 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_3 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_4 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_5 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_6 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_7 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_8 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_9 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_10 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_11 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_12 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_13 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_14 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_15 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_16 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_17 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_18 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_19 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_20 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_21 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_22 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_23 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_24 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_25 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_26 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_27 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_28 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_29 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_30 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_31 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_32 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_33 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_34 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_35 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_36 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_37 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_38 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_39 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_40 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_41 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_42 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_43 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_44 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_45 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_46 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_47 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	
	COMPONENT multadd
		PORT
		(
			clock0: IN STD_LOGIC  := '1';
			dataa_0: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			dataa_1: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			datab_0: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			datab_1: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			result: OUT STD_LOGIC_VECTOR (20 DOWNTO 0) :=  (OTHERS => '0')
		);
	END COMPONENT; --multadd
	
	COMPONENT sqrt
		PORT
		(
			clk: IN STD_LOGIC ;
			radical: IN STD_LOGIC_VECTOR (20 DOWNTO 0);
			q: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
			remainder: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
		);
	END COMPONENT; --sqrt
	
	BEGIN	
	multadd0 : multadd
		PORT MAP(clk_in, X0R,  X0R, X0I, X0I, sub_wire_0);
	sqrt0 : sqrt
		PORT MAP(clk_in, sub_wire_0, sub_wire_1);
	multadd1 : multadd
		PORT MAP(clk_in, X1R,  X1R, X1I, X1I, sub_wire_2);
	sqrt1 : sqrt
		PORT MAP(clk_in, sub_wire_2, sub_wire_3);
	multadd2 : multadd
		PORT MAP(clk_in, X2R,  X2R, X2I, X2I, sub_wire_4);
	sqrt2 : sqrt
		PORT MAP(clk_in, sub_wire_4, sub_wire_5);
	multadd3 : multadd
		PORT MAP(clk_in, X3R,  X3R, X3I, X3I, sub_wire_6);
	sqrt3 : sqrt
		PORT MAP(clk_in, sub_wire_6, sub_wire_7);
	multadd4 : multadd
		PORT MAP(clk_in, X4R,  X4R, X4I, X4I, sub_wire_8);
	sqrt4 : sqrt
		PORT MAP(clk_in, sub_wire_8, sub_wire_9);
	multadd5 : multadd
		PORT MAP(clk_in, X5R,  X5R, X5I, X5I, sub_wire_10);
	sqrt5 : sqrt
		PORT MAP(clk_in, sub_wire_10, sub_wire_11);
	multadd6 : multadd
		PORT MAP(clk_in, X6R,  X6R, X6I, X6I, sub_wire_12);
	sqrt6 : sqrt
		PORT MAP(clk_in, sub_wire_12, sub_wire_13);
	multadd7 : multadd
		PORT MAP(clk_in, X7R,  X7R, X7I, X7I, sub_wire_14);
	sqrt7 : sqrt
		PORT MAP(clk_in, sub_wire_14, sub_wire_15);
	multadd8 : multadd
		PORT MAP(clk_in, X8R,  X8R, X8I, X8I, sub_wire_16);
	sqrt8 : sqrt
		PORT MAP(clk_in, sub_wire_16, sub_wire_17);
	multadd9 : multadd
		PORT MAP(clk_in, X9R,  X9R, X9I, X9I, sub_wire_18);
	sqrt9 : sqrt
		PORT MAP(clk_in, sub_wire_18, sub_wire_19);
	multadd10 : multadd
		PORT MAP(clk_in, X10R,  X10R, X10I, X10I, sub_wire_20);
	sqrt10 : sqrt
		PORT MAP(clk_in, sub_wire_20, sub_wire_21);
	multadd11 : multadd
		PORT MAP(clk_in, X11R,  X11R, X11I, X11I, sub_wire_22);
	sqrt11 : sqrt
		PORT MAP(clk_in, sub_wire_22, sub_wire_23);
	multadd12 : multadd
		PORT MAP(clk_in, X12R,  X12R, X12I, X12I, sub_wire_24);
	sqrt12 : sqrt
		PORT MAP(clk_in, sub_wire_24, sub_wire_25);
	multadd13 : multadd
		PORT MAP(clk_in, X13R,  X13R, X13I, X13I, sub_wire_26);
	sqrt13 : sqrt
		PORT MAP(clk_in, sub_wire_26, sub_wire_27);
	multadd14 : multadd
		PORT MAP(clk_in, X14R,  X14R, X14I, X14I, sub_wire_28);
	sqrt14 : sqrt
		PORT MAP(clk_in, sub_wire_28, sub_wire_29);
	multadd15 : multadd
		PORT MAP(clk_in, X15R,  X15R, X15I, X15I, sub_wire_30);
	sqrt15 : sqrt
		PORT MAP(clk_in, sub_wire_30, sub_wire_31);
		
	PROCESS(clk_in, incoming128sets)
	BEGIN
		IF (incoming128sets = '1') THEN
			convert := '1';
			converting <= '1';
		END IF;
		IF (convert = '1') THEN
			IF rising_edge(clk_in) THEN
				CASE step IS
					WHEN 0 =>
						
					WHEN 7 =>
						V0 <= sub_wire_1;
						V1 <= sub_wire_3;
						V2 <= sub_wire_5;
						V3 <= sub_wire_7;
						V4 <= sub_wire_9;
						V5 <= sub_wire_11;
						V6 <= sub_wire_13;
						V7 <= sub_wire_15;
						V8 <= sub_wire_17;
						V9 <= sub_wire_19;
						V10 <= sub_wire_21;
						V11 <= sub_wire_23;
						V12 <= sub_wire_25;
						V13 <= sub_wire_27;
						V14 <= sub_wire_29;
						V15 <= sub_wire_31;
						convert := '1';
						step := 0;
						converting <= '1';
						count_fft := count_fft + 1; -- count to 128 then ssert fft_finished high
						
						IF (count_fft = 128) THEN
							fft_finished <= '1';
							count_fft := 0;
						END IF;
					WHEN OTHERS =>
						step := step + 1;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END convert;