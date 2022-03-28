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
USE WORK.PkgPRNG64.ALL;
--use std.textio.all;

ENTITY Debugger64 IS
  GENERIC( Debug : BOOLEAN );
  PORT( Clk  : IN STD_LOGIC ; Data : IN tData );
END Debugger64;

ARCHITECTURE rtl OF Debugger64 IS
BEGIN
-- PRAGMA SYNTHESIS OFF
  g : IF Debug GENERATE
    PROCESS( Clk )
      TYPE INTEGER_FILE IS FILE OF INTEGER;
      FILE out_file : INTEGER_FILE OPEN APPEND_MODE IS "NamedPipe";
    BEGIN
      IF RISING_EDGE( Clk ) THEN
        write( out_file , to_integer( Data(31 downto 0) ) );
        write( out_file , to_integer( Data(63 downto 32) ) );
      END IF;
    END PROCESS;    
  END GENERATE g;
-- PRAGMA SYNTHESIS ON
END ARCHITECTURE rtl;
-- -------------------------------------------------------------------------



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
USE WORK.PkgPRNG64.ALL;

ENTITY Xoshiro256starstar IS
  GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" ) ;
           Debug : BOOLEAN := FALSE );
  PORT( Clk  : IN STD_LOGIC ; Data : OUT tData );
END Xoshiro256starstar;

ARCHITECTURE rtl OF Xoshiro256starstar IS
  SIGNAL s : tArray( 0 TO 6 ) := Seed & tArray'( 64x"0" , 64x"0" , 64x"0" );
BEGIN
  s <= Xoshiro( s( 0 TO 3 ) ) & StarStarScrambler( s( 1 ) , s( 4 to 6 ) ) WHEN RISING_EDGE( Clk );
  Data <= s(6); -- Mapping    
  Dbg : ENTITY WORK.Debugger64 GENERIC MAP ( Debug ) PORT MAP ( Clk , s(6) );
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
