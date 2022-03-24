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

PACKAGE PkgPRNG IS
  GENERIC( Width : INTEGER );

  SUBTYPE tData IS UNSIGNED( Width-1 DOWNTO 0 );
  
  TYPE tArray IS ARRAY( INTEGER RANGE <> ) OF tData; 
  
  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray;

  FUNCTION Xoshiro ( signal s : tArray( 0 TO 3 ) ) RETURN tArray;
  FUNCTION StarStarScrambler ( signal t : tData ; signal s : tArray( 0 TO 2 ) ) RETURN tArray;
  FUNCTION PlusScrambler     ( signal ta : tData ; signal tb : tData ) RETURN tData;

END PACKAGE;

PACKAGE BODY PkgPRNG IS

  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray is
    VARIABLE Output : tArray( 0 TO Left'LENGTH-1 ) := (OTHERS=>(OTHERS=>'0'));
  BEGIN
    FOR i IN 0 TO Left'LENGTH-1 LOOP
      Output( i ) := Left( Left'LOW + i ) XOR Right( Right'LOW + i );
    END LOOP;
    RETURN Output;
  END FUNCTION "xor";
  

  FUNCTION Xoshiro ( signal s : tArray( 0 TO 3 ) ) RETURN tArray IS
    VARIABLE x : tArray( 0 TO 1 ) := (OTHERS=>(OTHERS=> '0'));
  BEGIN
    x := ( s(2) XOR s(0) , s(3) XOR s(1) ); -- Instantaneous
    RETURN ( s(0) XOR x(1) , s(1) XOR x(0) , x(0) XOR SHIFT_LEFT( s(1) , 17 ) , ROTATE_LEFT( x(1) , 45 ) );
  END FUNCTION Xoshiro;

  FUNCTION StarStarScrambler ( signal t : tData ; signal s : tArray( 0 TO 2 ) ) RETURN tArray IS
  BEGIN
    RETURN ( t + SHIFT_LEFT( t , 2 ) , ROTATE_LEFT( s(0) , 7 ) , s(1) + SHIFT_LEFT( s(1) , 3 ) );
  END FUNCTION StarStarScrambler;

  FUNCTION PlusScrambler ( signal ta : tData ; signal tb : tData ) RETURN tData IS
  BEGIN
    RETURN ( ta + tb );
  END FUNCTION PlusScrambler;



END PACKAGE BODY;



package PkgPRNG32 is new work.PkgPRNG generic map( Width => 32 );
package PkgPRNG64 is new work.PkgPRNG generic map( Width => 64 );
    
    