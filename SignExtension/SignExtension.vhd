library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

////////////////////////////////////////////////////////////////////////////////
// 
// Module - SignExtension.vhd
// Description - Sign extension module.  
// If the most significant bit of in (in[15]) = 0, 
//create the 32-bit "out" output by making out[15:0] equal to "in" and make other bits (bits 16 to 31) to 0
// If the most significant bit of in (in[15]) = 1, 
//create the 32-bit "out" output by making out[15:0] equal to "in" and make other bits to 1
////////////////////////////////////////////////////////////////////////////////
