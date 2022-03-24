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

-- LIBRARY IEEE;
-- USE IEEE.STD_LOGIC_1164.ALL;
-- -- USE IEEE.FLOAT_PKG.ALL;
-- USE IEEE.NUMERIC_STD.ALL;
-- USE STD.TEXTIO.ALL;

-- USE WORK.DataTypes.ALL;


-- ENTITY Xoshiro256float IS
  -- GENERIC( Seed : tArray( 0 TO 3 ) := ( x"01234567_89ABCDEF" , x"FEDCBA98_76543210" , x"F0E1D2C3_B4A59687" , x"78695A4B_3C2D1E0F" ) );
  -- PORT( Clk : IN STD_LOGIC ; Data : INOUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
-- END Xoshiro256float;

-- ARCHITECTURE rtl OF Xoshiro256float IS

  -- TYPE FloatUtil IS RECORD
    -- Exponent : INTEGER RANGE -128 TO 127;
    -- Mantissa : UNSIGNED( 127 DOWNTO 0 );
    -- Valid : BOOLEAN;
  -- END RECORD;
 
  -- TYPE FloatUtilArray IS ARRAY( NATURAL RANGE <> ) OF FloatUtil;

  -- SIGNAL s : tArray( -2 TO 3 ) := ( Seed( 2 ) XOR Seed( 0 ) , Seed( 3 ) XOR Seed( 1 ) , Seed( 0 ) , Seed( 1 ) , Seed( 2 ) , Seed( 3 ) );  
  -- SIGNAL t : tArray( 0 TO 2 ) := (OTHERS=>(OTHERS=>'0'));  
  -- SIGNAL u : FloatUtilArray( 0 TO 7 ) := (OTHERS=>( 0 , (OTHERS=>'0') , FALSE )); 
  
-- BEGIN
  -- s( -2 TO -1 ) <= ( s(2) XOR s(0)  , s(3) XOR s(1) ); -- Instantaneous; s(-2) and s(-1) are not truly part of the state, but used for convenience
  -- u( 0 ) <= ( 126 , s(1) & s(3) , TRUE ); -- No shifts corresponds to an exponent of -1

  -- Proc : PROCESS( Clk ) BEGIN
    -- IF RISING_EDGE( Clk ) THEN
      -- s( 0 TO 3 ) <= ( s(0) XOR s(-1) , s(1) XOR s(-2) , s(-2) XOR SHIFT_LEFT( s(1) , 17 ) , ROTATE_LEFT( s(-1) , 45 ) );
      -- t( 0 TO 2 ) <= ( s(1) + SHIFT_LEFT( s(1) , 2 ) , ROTATE_LEFT( t(0) , 7 ) , t(1) + SHIFT_LEFT( t(1) , 3 ) );

      -- IF u(7).Valid THEN
        -- Data <= "0" & STD_LOGIC_VECTOR( TO_SIGNED( u( 7 ).Exponent , 8 ) ) & STD_LOGIC_VECTOR( t( 2 )( 63 DOWNTO 41 ) );
      -- ELSE
        -- Data <= STD_LOGIC_VECTOR'(32x"FF800001"); -- NAN
      -- END IF;
    -- END IF;
  -- END PROCESS;

  -- G : FOR i IN 0 TO 6 GENERATE
    -- CONSTANT SIZE : NATURAL := 2**(6-i);
  -- BEGIN
    -- Proc : PROCESS( Clk ) BEGIN
      -- IF RISING_EDGE( Clk ) THEN
        -- IF u( i ).Mantissa( 127 DOWNTO ( 128 - SIZE ) ) = TO_UNSIGNED( 0 , SIZE ) THEN
          -- u( i+1 ) <= ( u( i ).Exponent - SIZE , SHIFT_LEFT( u( i ).Mantissa , SIZE ) , u( i ).Valid );
        -- ELSE
          -- u( i+1 ) <= u( i );
        -- END IF;
      -- END IF;
    -- END PROCESS;
  -- END GENERATE;

  
  -- -- Debug : PROCESS( Clk )
    -- -- FILE f     : TEXT OPEN write_mode IS "./Xoshiro256float2.txt";
    -- -- VARIABLE s : LINE;
  -- -- BEGIN
    -- -- IF RISING_EDGE( Clk ) THEN
        -- -- WRITE( s , TO_REAL( TO_FLOAT( Data ) ) );
        -- -- WRITELINE( f , s );
    -- -- END IF;
  -- -- END PROCESS;  
  
  
-- END ARCHITECTURE rtl;
