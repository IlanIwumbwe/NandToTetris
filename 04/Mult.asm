// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

// SOW: add RO to itself R1 times
	
	// R2 = O
	@R2
	M = 0
	
	// count = 0
	@count	
	M = 0
	
(LOOP)
	// if count == R1, goto STOP
	@ count
	D = M
	@R1
	D = D - M
	@STOP
	D;JEQ
	
	@R2
	D = M
	@R0
	D = D + M
	@R2
	M = D

	@count
	M = M + 1
	
	@LOOP
	0;JEQ
(STOP)
	@STOP
	0;JEQ
	