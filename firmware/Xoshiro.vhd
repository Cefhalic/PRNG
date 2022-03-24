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

-- -- -------------------------------------------------------------------------
-- LIBRARY IEEE;
-- USE IEEE.STD_LOGIC_1164.ALL;
-- USE WORK.PkgPRNG64.ALL;

-- ENTITY Xoshiro256plus IS
  -- GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" ) );
  -- PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
-- END Xoshiro256plus;

-- ARCHITECTURE rtl OF Xoshiro256plus IS
  -- SIGNAL s : tArray( 0 TO 3 ) := Seed;
-- BEGIN
  -- s <= Xoshiro( s( 0 TO 3 ) ) WHEN RISING_EDGE( Clk );
  -- Data <= PlusScrambler( s(0) , s(3) ) WHEN RISING_EDGE( Clk );
-- END ARCHITECTURE rtl;
-- -- -------------------------------------------------------------------------


-- -- -------------------------------------------------------------------------
-- LIBRARY IEEE;
-- USE IEEE.STD_LOGIC_1164.ALL;
-- USE WORK.PkgPRNG32.ALL;

-- ENTITY Xoshiro128plus IS
  -- GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567" , x"89ABCDEF" , x"FEDCBA98" , x"76543210" ) );
  -- PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
-- END Xoshiro128plus;

-- ARCHITECTURE rtl OF Xoshiro128plus IS
  -- SIGNAL s : tArray( 0 TO 3 ) := Seed;
-- BEGIN
  -- s <= Xoshiro( s( 0 TO 3 ) ) WHEN RISING_EDGE( Clk );
  -- Data <= PlusScrambler( s(0) , s(3) ) WHEN RISING_EDGE( Clk ); 
-- END ARCHITECTURE rtl;
-- -- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.PkgPRNG64.ALL;

use std.textio.all;

ENTITY Xoshiro256starstar IS
  GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" ) );
  PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
END Xoshiro256starstar;

ARCHITECTURE rtl OF Xoshiro256starstar IS
  SIGNAL s : tArray( 0 TO 6 ) := Seed & tArray'( 64x"0" , 64x"0" , 64x"0" );
BEGIN
  s <= Xoshiro( s( 0 TO 3 ) ) & StarStarScrambler( s( 1 ) , s( 4 to 6 ) ) WHEN RISING_EDGE( Clk );
  Data <= s(6); -- Mapping  
  
  Debug : PROCESS( Clk )
  BEGIN
    IF RISING_EDGE( Clk ) THEN
      write( output , to_hstring( s(6) ) & LF );
    END IF;
  END PROCESS;    
  
  
END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------


-- -- -------------------------------------------------------------------------
-- LIBRARY IEEE;
-- USE IEEE.STD_LOGIC_1164.ALL;
-- USE WORK.PkgPRNG32.ALL;

-- ENTITY Xoshiro128starstar IS
  -- GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567" , x"89ABCDEF" , x"FEDCBA98" , x"76543210" ) );
  -- PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
-- END Xoshiro128starstar;

-- ARCHITECTURE rtl OF Xoshiro128starstar IS
  -- SIGNAL s : tArray( 0 TO 6 ) := Seed & tArray'( 64x"0" , 64x"0" , 64x"0" );
-- BEGIN
  -- s <= Xoshiro( s( 0 TO 3 ) ) & StarStarScrambler( s( 1 ) , s( 4 to 6 ) ) WHEN RISING_EDGE( Clk );
  -- Data <= s(6); -- Mapping  
-- END ARCHITECTURE rtl;
-- -- -------------------------------------------------------------------------
