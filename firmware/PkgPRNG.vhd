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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- =================================================================================================================================
PACKAGE PkgPRNG IS
  GENERIC( Width : INTEGER );

  SUBTYPE tData IS SIGNED( Width-1 DOWNTO 0 );
  TYPE tArray IS ARRAY( INTEGER RANGE <> ) OF tData; 
  
  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray;

  PROCEDURE Xoshiro           ( SIGNAL s : INOUT tArray( 0 TO 3 ) );
  PROCEDURE StarStarScrambler ( SIGNAL s : IN tData ; SIGNAL t : INOUT tArray( 0 TO 2 ) );
  PROCEDURE PlusScrambler     ( SIGNAL sa : IN tData ; SIGNAL sb : IN tData ; SIGNAL t : OUT tArray( 0 TO 0 ) );

  PROCEDURE Debug             ( CONSTANT Debugging : IN BOOLEAN ; SIGNAL t : IN tData );

-- PRAGMA SYNTHESIS OFF
  TYPE INTEGER_FILE IS FILE OF INTEGER;
  FILE OUT_FILE : INTEGER_FILE OPEN APPEND_MODE IS "../NamedPipe";
-- PRAGMA SYNTHESIS ON

END PACKAGE;
-- =================================================================================================================================

-- =================================================================================================================================
PACKAGE BODY PkgPRNG IS

  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray is
    VARIABLE Output : tArray( 0 TO Left'LENGTH-1 ) := (OTHERS=>(OTHERS=>'0'));
  BEGIN
    FOR i IN 0 TO Left'LENGTH-1 LOOP
      Output( i ) := Left( Left'LOW + i ) XOR Right( Right'LOW + i );
    END LOOP;
    RETURN Output;
  END FUNCTION "xor";
  
  PROCEDURE Xoshiro ( signal s : INOUT tArray( 0 TO 3 ) ) IS
    VARIABLE x : tArray( 0 TO 1 ) := (OTHERS=>(OTHERS=> '0'));
  BEGIN
    x := ( s(2) XOR s(0) , s(3) XOR s(1) ); -- Instantaneous
    s <= ( s(0) XOR x(1) , s(1) XOR x(0) , x(0) XOR SHIFT_LEFT( s(1) , 17 ) , ROTATE_LEFT( x(1) , 45 ) );
  END PROCEDURE Xoshiro;

  PROCEDURE StarStarScrambler ( signal s : IN tData ; signal t : INOUT tArray( 0 TO 2 ) ) IS
  BEGIN
    t <= ( s + SHIFT_LEFT( s , 2 ) , ROTATE_LEFT( t(0) , 7 ) , t(1) + SHIFT_LEFT( t(1) , 3 ) );
  END PROCEDURE StarStarScrambler;

  PROCEDURE PlusScrambler ( SIGNAL sa : IN tData ; SIGNAL sb : IN tData ; SIGNAL t : OUT tArray( 0 TO 0 ) ) IS
  BEGIN
    t(0) <= sa + sb;
  END PROCEDURE PlusScrambler;
  
  PROCEDURE Debug ( CONSTANT Debugging : IN BOOLEAN ; SIGNAL t : IN tData ) IS
  BEGIN
-- PRAGMA SYNTHESIS OFF
    IF Debugging THEN
      FOR i IN 1 TO (Width/32) LOOP
        WRITE( OUT_FILE , TO_INTEGER( t( (32*i)-1 DOWNTO 32*(i-1) ) ) );
      END LOOP;
    END IF;
-- PRAGMA SYNTHESIS ON
  END PROCEDURE;    

END PACKAGE BODY;
-- =================================================================================================================================

-- =================================================================================================================================
PACKAGE PkgPRNG32 IS NEW WORK.PkgPRNG GENERIC MAP( Width => 32 );
PACKAGE PkgPRNG64 IS NEW WORK.PkgPRNG GENERIC MAP( Width => 64 );
-- =================================================================================================================================
       
