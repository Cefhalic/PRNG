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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.DataTypes.ALL;

ENTITY Xoshiro256 IS
  GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" ) );
  PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
END Xoshiro256;

ARCHITECTURE rtl OF Xoshiro256 IS
  SIGNAL s : tArray( -2 TO 3 ) := ( Seed( 2 ) XOR Seed( 0 ) , Seed( 3 ) XOR Seed( 1 ) , Seed( 0 ) , Seed( 1 ) , Seed( 2 ) , Seed( 3 ) );
BEGIN
  s( -2 TO -1 ) <= ( s(2) XOR s(0)  , s(3) XOR s(1) ); -- Instantaneous; s(-2) and s(-1) are not truly part of the state, but used for convenience
  s( 0 TO 3 )   <= ( s(0) XOR s(-1) , s(1) XOR s(-2) , s(-2) XOR SHIFT_LEFT( s(1) , 17 ) , ROTATE_LEFT( s(-1) , 45 ) ) WHEN RISING_EDGE( Clk ); -- Clocked
  Data          <= s(1); -- Mapping
END ARCHITECTURE rtl;
