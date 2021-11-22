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

ENTITY StarStarScrambler IS
  PORT( Clk     :  IN  STD_LOGIC;
        DataIn  :  IN tData;
        DataOut : OUT tData );
END StarStarScrambler;

ARCHITECTURE rtl OF StarStarScrambler IS
  SIGNAL Pipeline : tArray( 0 TO 2 ) := (OTHERS=>(OTHERS=>'0'));
BEGIN
  Pipeline <= ( DataIn + SHIFT_LEFT( DataIn , 2 ) , ROTATE_LEFT( Pipeline(0) , 7 ) , Pipeline(1) + SHIFT_LEFT( Pipeline(1) , 3 ) ) WHEN RISING_EDGE( Clk ); -- Clocked 
  DataOut  <= Pipeline(2); -- Mapping
END ARCHITECTURE rtl;
