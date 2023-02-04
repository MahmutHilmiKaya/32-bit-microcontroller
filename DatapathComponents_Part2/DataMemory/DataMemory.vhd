

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Dr. Burak Unal
// 
// Module - data_memory.vhd
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K (x32) memory, for which we need 10 bits for the address.  
// In order to implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. 
// The 'WriteData' value is written into the location whose address 
// corresponds to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 
// 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is NOT clocked.
//
// you need to declare a 2d array. in this case we need 
// an array of 1024 (1K) 32-bit elements (1024 elements where each element is 32-bit wide).  
// 
////////////////////////////////////////////////////////////////////////////////

