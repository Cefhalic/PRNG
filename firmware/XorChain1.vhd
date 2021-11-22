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

ENTITY XorChain1 IS
  GENERIC( cChainLength : INTEGER );
  PORT( Clk  : IN STD_LOGIC ; DataInA : IN tData ; DataInB : IN tData ; DataOut : OUT tArray( 0 TO cChainLength-1 ) := (OTHERS=>(OTHERS=>'0')) );
END XorChain1;

ARCHITECTURE rtl OF XorChain1 IS
  SIGNAL PipelineA , PipelineB : tArray( 0 to cChainLength-1 ) := (OTHERS=>(OTHERS=>'0'));
BEGIN
  PipelineA <= DataInA & PipelineA( 0 to cChainLength-2 ) WHEN RISING_EDGE( Clk ); -- Pipelineline
  PipelineB <= PipelineB( 1 to cChainLength-1 ) & DataInB WHEN RISING_EDGE( Clk ); -- Pipelineline
  DataOut   <= PipelineA XOR PipelineB WHEN RISING_EDGE( Clk ); -- XOR
END ARCHITECTURE rtl;
