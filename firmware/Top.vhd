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
USE WORK.PkgPRNG64.ALL;

ENTITY Top IS
  -- GENERIC( UsePull : BOOLEAN;
           -- UseReset : BOOLEAN );
  PORT( Clk   : IN STD_LOGIC;
        Pull  : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Data_With_Pull_And_Reset : OUT tData;
        Data_With_Pull_No_Reset  : OUT tData;
        Data_No_Pull_With_Reset  : OUT tData;
        Data_No_Pull_No_Reset    : OUT tData );
END Top;

ARCHITECTURE rtl OF Top IS
  SIGNAL PullInt , ResetInt : BOOLEAN;
BEGIN

  PullInt  <= ( Pull = '1' );
  ResetInt <= ( Reset = '1' );

  -- G1 : IF UseReset AND UsePull GENERATE
    Instance0 : ENTITY WORK.Xoshiro256starstar GENERIC MAP( Debugging => TRUE ) PORT MAP( Clk => Clk , Data => Data_With_Pull_And_Reset , Pull => PullInt , Reset => ResetInt );
  -- ELSIF UsePull GENERATE
    Instance1 : ENTITY WORK.Xoshiro256starstar GENERIC MAP( Debugging => TRUE ) PORT MAP( Clk => Clk , Data => Data_With_Pull_No_Reset  , Pull  => PullInt                    );
  -- ELSIF UseReset GENERATE
    Instance2 : ENTITY WORK.Xoshiro256starstar GENERIC MAP( Debugging => TRUE ) PORT MAP( Clk => Clk , Data => Data_No_Pull_With_Reset  ,                   Reset => ResetInt );
  -- ELSE GENERATE
    Instance3 : ENTITY WORK.Xoshiro256starstar GENERIC MAP( Debugging => TRUE ) PORT MAP( Clk => Clk , Data => Data_No_Pull_No_Reset                                          );
  -- END IF;

END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------
