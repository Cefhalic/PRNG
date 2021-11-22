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

PACKAGE DataTypes IS
  SUBTYPE tData IS UNSIGNED( 63 DOWNTO 0 );
  TYPE tArray IS ARRAY( INTEGER RANGE <> ) OF tData; 
  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray;
END PACKAGE;

PACKAGE BODY DataTypes IS
  FUNCTION "xor" ( Left , Right : tArray ) RETURN tArray is
    VARIABLE Output : tArray( 0 TO Left'LENGTH-1 ) := (OTHERS=>(OTHERS=>'0'));
  BEGIN
    FOR i IN 0 TO Left'LENGTH-1 LOOP
      Output( i ) := Left( Left'LOW + i ) XOR Right( Right'LOW + i );
    END LOOP;
    RETURN Output;
  END FUNCTION "xor";
END PACKAGE BODY;
