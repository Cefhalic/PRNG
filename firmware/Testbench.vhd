-- #########################################################################
-- #########################################################################
-- ###                                                                   ###
-- ###   Use of this code, whether in its current form or modified,      ###
-- ###   implies that you consent to the terms and conditions, namely:   ###
-- ###    - You acknowledge my contribution                              ###
-- ###    - This copyright notification remains intact                   ###
-- ###                                                                   ###
-- ###   Many thanks,                                                    ###
-- ###     Dr. Andrew W. Rose, Imperial College London, 2021             ###
-- ###                                                                   ###
-- #########################################################################
-- #########################################################################

-- -------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.PkgPRNG64bit.ALL;

ENTITY Testbench64bit IS
  PORT( Clk   : IN STD_LOGIC;
        Pull  : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        ResetValIn : IN STD_LOGIC;
        SelectIn : IN UNSIGNED( 2 DOWNTO 0 );
        DataOut  : OUT tData );
END Testbench64bit;

ARCHITECTURE rtl OF Testbench64bit IS
  SIGNAL PullInt , ResetInt : BOOLEAN;
  SIGNAL ValueShiftReg : SIGNED( 255 DOWNTO 0 ) := (OTHERS=>'0');
  SIGNAL ResetVal : tArray( 0 TO 3 ) := (OTHERS=>(OTHERS=>'0'));
  SIGNAL Data_With_Pull_And_Reset , Data_With_Pull_No_Reset , Data_No_Pull_With_Reset , 
         Data_No_Pull_No_Reset , Data_With_Pull_And_ResetVal , Data_No_Pull_With_ResetVal  : tData;
BEGIN

  PROCESS ( Clk )
  BEGIN
    IF RISING_EDGE( Clk ) THEN
      ValueShiftReg <= ValueShiftReg( 254 DOWNTO 0 ) & ResetValIn;
          
      CASE TO_INTEGER( SelectIn ) IS
        WHEN 0 =>      DataOut <= Data_With_Pull_And_Reset;
        WHEN 1 =>      DataOut <= Data_With_Pull_No_Reset;
        WHEN 2 =>      DataOut <= Data_No_Pull_With_Reset;
        WHEN 3 =>      DataOut <= Data_No_Pull_No_Reset;
        WHEN 4 =>      DataOut <= Data_With_Pull_And_ResetVal;
        WHEN 5 =>      DataOut <= Data_No_Pull_With_ResetVal;
        WHEN OTHERS => DataOut <= (OTHERS => '0');
      END CASE;
    END IF;
  END PROCESS;

  PullInt  <= ( Pull = '1' );
  ResetInt <= ( Reset = '1' );
  ResetVal <= ( ValueShiftReg( 255 DOWNTO 192 ) , ValueShiftReg( 191 DOWNTO 128 ) , ValueShiftReg( 127 DOWNTO 64 ) , ValueShiftReg( 63 DOWNTO 0 ) );

  Instance0 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_With_Pull_And_Reset    , Pull => PullInt , Reset => ResetInt                        );
  Instance1 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_With_Pull_No_Reset     , Pull => PullInt                                            );
  Instance2 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_No_Pull_With_Reset     ,                   Reset => ResetInt                        );
  Instance3 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_No_Pull_No_Reset                                                                    );
  Instance4 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_With_Pull_And_ResetVal , Pull => PullInt , Reset => ResetInt , ResetVal => ResetVal );
  Instance5 : ENTITY WORK.Xoshiro64bit PORT MAP( Clk => Clk , Data => Data_No_Pull_With_ResetVal  ,                   Reset => ResetInt , ResetVal => ResetVal );

END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.PkgPRNG64bit.ALL;
USE WORK.PkgPRNGdouble.ALL;

ENTITY TestbenchDouble IS
  PORT( Clk   : IN STD_LOGIC;
        Pull  : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        ResetValIn : IN STD_LOGIC;
        SelectIn : IN UNSIGNED( 2 DOWNTO 0 );
        DataOut  : OUT tFpData );
END TestbenchDouble;

ARCHITECTURE rtl OF TestbenchDouble IS
  SIGNAL PullInt , ResetInt : BOOLEAN;
  SIGNAL ValueShiftReg : SIGNED( 255 DOWNTO 0 ) := (OTHERS=>'0');
  SIGNAL ResetVal : tArray( 0 TO 3 ) := (OTHERS=>(OTHERS=>'0'));
  SIGNAL Data_With_Pull_And_Reset , Data_With_Pull_No_Reset , Data_No_Pull_With_Reset , 
         Data_No_Pull_No_Reset , Data_With_Pull_And_ResetVal , Data_No_Pull_With_ResetVal  : tFpData;
BEGIN

  PROCESS ( Clk )
  BEGIN
    IF RISING_EDGE( Clk ) THEN
      ValueShiftReg <= ValueShiftReg( 254 DOWNTO 0 ) & ResetValIn;
          
      CASE TO_INTEGER( SelectIn ) IS
        WHEN 0 =>      DataOut <= Data_With_Pull_And_Reset;
        WHEN 1 =>      DataOut <= Data_With_Pull_No_Reset;
        WHEN 2 =>      DataOut <= Data_No_Pull_With_Reset;
        WHEN 3 =>      DataOut <= Data_No_Pull_No_Reset;
        WHEN 4 =>      DataOut <= Data_With_Pull_And_ResetVal;
        WHEN 5 =>      DataOut <= Data_No_Pull_With_ResetVal;
        WHEN OTHERS => DataOut <= (OTHERS => '0');
      END CASE;
    END IF;
  END PROCESS;

  PullInt  <= ( Pull = '1' );
  ResetInt <= ( Reset = '1' );
  ResetVal <= ( ValueShiftReg( 255 DOWNTO 192 ) , ValueShiftReg( 191 DOWNTO 128 ) , ValueShiftReg( 127 DOWNTO 64 ) , ValueShiftReg( 63 DOWNTO 0 ) );

  Instance0 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_With_Pull_And_Reset    , Pull => PullInt , Reset => ResetInt                        );
  Instance1 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_With_Pull_No_Reset     , Pull => PullInt                                            );
  Instance2 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_No_Pull_With_Reset     ,                   Reset => ResetInt                        );
  Instance3 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_No_Pull_No_Reset                                                                    );
  Instance4 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_With_Pull_And_ResetVal , Pull => PullInt , Reset => ResetInt , ResetVal => ResetVal );
  Instance5 : ENTITY WORK.Xoshiro256double PORT MAP( Clk => Clk , Data => Data_No_Pull_With_ResetVal  ,                   Reset => ResetInt , ResetVal => ResetVal );

END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------