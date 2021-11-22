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
USE WORK.DataTypes.ALL;

ENTITY XorChain2 IS
  GENERIC( cChainLength : INTEGER );
  PORT( Clk  : IN STD_LOGIC ; DataInA : IN tData ; DataInB : IN tData ; DataOut : OUT tArray( 0 TO cChainLength-1 ) := (OTHERS=>(OTHERS=>'0')) );
END XorChain2;

ARCHITECTURE rtl OF XorChain2 IS
  SIGNAL Pipeline : tArray( -1 to cChainLength ) := (OTHERS=>(OTHERS=>'0'));
BEGIN
  Pipeline <= DataInA & ( Pipeline( -1 TO cChainLength-2 ) XOR Pipeline( 1 TO cChainLength ) ) & DataInB WHEN RISING_EDGE( Clk ); -- Clocked Logic
  DataOut  <= Pipeline( 0 TO cChainLength-1 ); -- Mapping
END ARCHITECTURE rtl;
