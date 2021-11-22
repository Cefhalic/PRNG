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

USE WORK.DataTypes.ALL;

ENTITY Top IS
  GENERIC( cChainLength : INTEGER := 5 );
  PORT( Clk     : IN  STD_LOGIC;
        C1 : OUT tArray( 0 TO cChainLength-1 ) := (OTHERS=>(OTHERS=>'0'));
        C2 : OUT tArray( 0 TO cChainLength-1 ) := (OTHERS=>(OTHERS=>'0')) );
END Top;

ARCHITECTURE rtl OF Top IS
  SIGNAL A1,B1: tData := (OTHERS=>'0');  
  SIGNAL A2,B2: tData := (OTHERS=>'0');  
BEGIN


  XoshiroInstanceA : ENTITY work.Xoshiro256
  GENERIC MAP( ( x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" , x"01234567_89ABCDEF" , x"FEDCBA98_76543210" ) )
  PORT MAP( Clk , A1 );

  StarStarScramblerInstanceA: ENTITY work.StarStarScrambler
  PORT MAP( Clk , A1 , A2 );  


  XoshiroInstanceB : ENTITY work.Xoshiro256
  GENERIC MAP( ( x"78695A4B_3C2D1E0F" , x"89ABCDEF_FEDCBA98" , x"76543210_F0E1D2C3" , x"B4A59687_01234567" ) )
  PORT MAP( Clk , B1 );

  StarStarScramblerInstanceB: ENTITY work.StarStarScrambler
  PORT MAP( Clk , B1 , B2 );  

  XorChain1Instance : ENTITY work.XorChain1
  GENERIC MAP( cChainLength )
  PORT MAP( Clk , A2 , B2 , C1 );

  XorChain2Instance : ENTITY work.XorChain2
  GENERIC MAP( cChainLength )
  PORT MAP( Clk , A2 , B2 , C2 );


END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------
