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

-- =================================================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.PkgPRNG64.ALL;
USE WORK.PkgPRNGdouble.ALL;


ENTITY Xoshiro256double IS
  GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" );
           Debugging : BOOLEAN := FALSE );
  PORT( Clk  : IN STD_LOGIC ;
        Data : OUT tFpData ;
        Pull : IN BOOLEAN := TRUE;
        Reset : IN BOOLEAN := FALSE;
        ResetVal : IN tArray( 0 TO 3 ) := Seed
        );
END Xoshiro256double;


ARCHITECTURE rtl OF Xoshiro256double IS
  SIGNAL s : tArray( 0 TO 3 ) := Seed;
  SIGNAL t : tArray( 0 TO 2 ) := ( OTHERS => 64x"0" );
  SIGNAL u : tUtilArray( 1 TO 7 ) := (OTHERS=>( 0 , (OTHERS=>'0') , FALSE )); 
  SIGNAL v : SIGNED( 127 DOWNTO 0 );
  SIGNAL w : tFpData ;
BEGIN
    v <= s( 3 ) & s( 1 );
    Data <= w;

    PROCESS( Clk ) BEGIN
      IF RISING_EDGE( Clk ) THEN
        IF Reset THEN
          s <= ResetVal;
          t <= ( OTHERS => 64x"0" );
          u <= ( OTHERS=>( 0 , (OTHERS=>'0') , FALSE ) );
          w <= 64x"7FFFFFFFFFFFFFFF";
        ELSIF Pull THEN
          Xoshiro( s );
          StarStarScrambler( s( 1 ) , t );         
          CountZeros( v ,  u );
          ToIEEE754( u(7) , t(2) , w );
          -- Debug( Debugging , t( 2 ) );          
        END IF;       
      END IF;
    END PROCESS;    
END ARCHITECTURE rtl;
-- =================================================================================================================================
