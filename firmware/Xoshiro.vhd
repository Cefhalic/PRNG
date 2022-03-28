-- #########################################################################
-- #########################################################################
-- ###                                                                   ###
-- ###   Use of this code, whether in its current form or modified,      ###
-- ###   implies that you consent to the terms and conditions, namely:   ###
-- ###    - You acknowledge my contribution                              ###
-- ###    - This copyright notification remains intact                   ###
-- ###                                                                   ###
-- ###   Many thanks,                                                    ###
-- ###     Dr. Andrew W. Rose, Imperial College London, 2021-2022        ###
-- ###                                                                   ###
-- #########################################################################
-- #########################################################################

-- =================================================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.PkgPRNG64.ALL;

ENTITY Xoshiro256starstar IS
  GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" );
           Debugging : BOOLEAN := FALSE );
  PORT( Clk  : IN STD_LOGIC ;
        Data : OUT tData ;
        Pull : IN BOOLEAN := TRUE;
        Reset : IN BOOLEAN := FALSE;
        ResetVal : IN tArray( 0 TO 3 ) := Seed
        );
END Xoshiro256starstar;

ARCHITECTURE rtl OF Xoshiro256starstar IS
  SIGNAL s : tArray( 0 TO 3 ) := Seed;
  SIGNAL t : tArray( 0 TO 2 ) := ( OTHERS => 64x"0" );
BEGIN
    PROCESS( Clk ) BEGIN
      IF RISING_EDGE( Clk ) THEN
        IF Reset THEN
          s <= ResetVal;
          t <= ( OTHERS => 64x"0" );
        ELSIF Pull THEN
          Xoshiro( s );
          StarStarScrambler( s( 1 ) , t );
          Debug( Debugging , t( 2 ) );
        END IF;
      END IF;
    END PROCESS;    
    Data <= t(2);
END ARCHITECTURE rtl;
-- =================================================================================================================================
