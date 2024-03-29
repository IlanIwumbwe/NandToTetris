// bootstrap code, set SP=256, and call Sys.init
@256
D=A
@SP
M=D
// push stack frame of caller
@$ret.0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@5
D=D-A
@ARG
M=D
//GOTO function
@Sys.init
0;JMP
($ret.0)
//function PongGame.new 0
(PongGame.new)
//push constant 7
@7
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Memory.alloc 1
// push stack frame of caller
@PongGame.new$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Memory.alloc
0;JMP
(PongGame.new$ret.1)
//pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
//call Screen.clearScreen 0
// push stack frame of caller
@PongGame.new$ret.2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@5
D=D-A
@ARG
M=D
//GOTO function
@Screen.clearScreen
0;JMP
(PongGame.new$ret.2)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 50
@50
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop this 6
@THIS
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 230
@230
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 229
@229
D=A
@SP
A=M
M=D
@SP
M=M+1
//push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 7
@7
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Bat.new 4
// push stack frame of caller
@PongGame.new$ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@9
D=D-A
@ARG
M=D
//GOTO function
@Bat.new
0;JMP
(PongGame.new$ret.3)
//pop this 0
@THIS
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 253
@253
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 222
@222
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 511
@511
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 229
@229
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Ball.new 6
// push stack frame of caller
@PongGame.new$ret.4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@11
D=D-A
@ARG
M=D
//GOTO function
@Ball.new
0;JMP
(PongGame.new$ret.4)
//pop this 1
@THIS
D=M
@1
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 400
@400
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Ball.setDestination 3
// push stack frame of caller
@PongGame.new$ret.5
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@8
D=D-A
@ARG
M=D
//GOTO function
@Ball.setDestination
0;JMP
(PongGame.new$ret.5)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 238
@238
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 511
@511
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 240
@240
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Screen.drawRectangle 4
// push stack frame of caller
@PongGame.new$ret.6
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@9
D=D-A
@ARG
M=D
//GOTO function
@Screen.drawRectangle
0;JMP
(PongGame.new$ret.6)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Output.moveCursor 2
// push stack frame of caller
@PongGame.new$ret.7
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Output.moveCursor
0;JMP
(PongGame.new$ret.7)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.new 1
// push stack frame of caller
@PongGame.new$ret.8
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@String.new
0;JMP
(PongGame.new$ret.8)
//push constant 83
@83
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.9
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.9)
//push constant 99
@99
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.10
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.10)
//push constant 111
@111
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.11
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.11)
//push constant 114
@114
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.12
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.12)
//push constant 101
@101
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.13
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.13)
//push constant 58
@58
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.14
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.14)
//push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.15
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.15)
//push constant 48
@48
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.new$ret.16
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.new$ret.16)
//call Output.printString 1
// push stack frame of caller
@PongGame.new$ret.17
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Output.printString
0;JMP
(PongGame.new$ret.17)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop this 5
@THIS
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push pointer 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push pointer 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
//function PongGame.dispose 0
(PongGame.dispose)
//push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.dispose 1
// push stack frame of caller
@PongGame.dispose$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Bat.dispose
0;JMP
(PongGame.dispose$ret.1)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Ball.dispose 1
// push stack frame of caller
@PongGame.dispose$ret.2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Ball.dispose
0;JMP
(PongGame.dispose$ret.2)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push pointer 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Memory.deAlloc 1
// push stack frame of caller
@PongGame.dispose$ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Memory.deAlloc
0;JMP
(PongGame.dispose$ret.3)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
//function PongGame.newInstance 0
(PongGame.newInstance)
//call PongGame.new 0
// push stack frame of caller
@PongGame.newInstance$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@5
D=D-A
@ARG
M=D
//GOTO function
@PongGame.new
0;JMP
(PongGame.newInstance$ret.1)
//pop static 0
@SP
AM=M-1
D=M
@.0
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
//function PongGame.getInstance 0
(PongGame.getInstance)
//push static 0
@.0
D=M
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
//function PongGame.run 1
(PongGame.run)
@SP
A=M
M=0
@SP
M=M+1
//push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
//label LOOP_START0
(PongGame.run$LOOP_START0)
//push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//not
@SP
A=M
A=A-1
M=!M
//if-goto LOOP_END0
@SP
AM=M-1
D=M
@PongGame.run$LOOP_END0
D;JNE
//label LOOP_START0
(PongGame.run$LOOP_START0)
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE101
D;JEQ
D=0
@PUSHTOSTACK101
0;JMP
(TRUE101)
D=-1
(PUSHTOSTACK101)
@SP
A=M
M=D
@SP
M=M+1
//push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//and
@SP
AM=M-1
D=M
A=A-1
M=M&D
//not
@SP
A=M
A=A-1
M=!M
//if-goto LOOP_END0
@SP
AM=M-1
D=M
@PongGame.run$LOOP_END0
D;JNE
//call Keyboard.keyPressed 0
// push stack frame of caller
@PongGame.run$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@5
D=D-A
@ARG
M=D
//GOTO function
@Keyboard.keyPressed
0;JMP
(PongGame.run$ret.1)
//pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.move 1
// push stack frame of caller
@PongGame.run$ret.2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Bat.move
0;JMP
(PongGame.run$ret.2)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push pointer 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call PongGame.moveBall 1
// push stack frame of caller
@PongGame.run$ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@PongGame.moveBall
0;JMP
(PongGame.run$ret.3)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 50
@50
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Sys.wait 1
// push stack frame of caller
@PongGame.run$ret.4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Sys.wait
0;JMP
(PongGame.run$ret.4)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto LOOP_START0
@PongGame.run$LOOP_START0
0;JMP
//label LOOP_END0
(PongGame.run$LOOP_END0)
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 130
@130
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE122
D;JEQ
D=0
@PUSHTOSTACK122
0;JMP
(TRUE122)
D=-1
(PUSHTOSTACK122)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE1
@SP
AM=M-1
D=M
@PongGame.run$FALSE1
D;JNE
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Bat.setDirection 2
// push stack frame of caller
@PongGame.run$ret.5
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Bat.setDirection
0;JMP
(PongGame.run$ret.5)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END1
@PongGame.run$COND_END1
0;JMP
//label FALSE1
(PongGame.run$FALSE1)
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 132
@132
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE133
D;JEQ
D=0
@PUSHTOSTACK133
0;JMP
(TRUE133)
D=-1
(PUSHTOSTACK133)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE1
@SP
AM=M-1
D=M
@PongGame.run$FALSE1
D;JNE
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Bat.setDirection 2
// push stack frame of caller
@PongGame.run$ret.6
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Bat.setDirection
0;JMP
(PongGame.run$ret.6)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END1
@PongGame.run$COND_END1
0;JMP
//label FALSE1
(PongGame.run$FALSE1)
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 140
@140
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE144
D;JEQ
D=0
@PUSHTOSTACK144
0;JMP
(TRUE144)
D=-1
(PUSHTOSTACK144)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE1
@SP
AM=M-1
D=M
@PongGame.run$FALSE1
D;JNE
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END1
@PongGame.run$COND_END1
0;JMP
//label FALSE1
(PongGame.run$FALSE1)
//label COND_END1
(PongGame.run$COND_END1)
//label COND_END2
(PongGame.run$COND_END2)
//label COND_END3
(PongGame.run$COND_END3)
//label LOOP_START4
(PongGame.run$LOOP_START4)
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE158
D;JEQ
D=0
@PUSHTOSTACK158
0;JMP
(TRUE158)
D=-1
(PUSHTOSTACK158)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//and
@SP
AM=M-1
D=M
A=A-1
M=M&D
//not
@SP
A=M
A=A-1
M=!M
//if-goto LOOP_END4
@SP
AM=M-1
D=M
@PongGame.run$LOOP_END4
D;JNE
//call Keyboard.keyPressed 0
// push stack frame of caller
@PongGame.run$ret.7
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@5
D=D-A
@ARG
M=D
//GOTO function
@Keyboard.keyPressed
0;JMP
(PongGame.run$ret.7)
//pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.move 1
// push stack frame of caller
@PongGame.run$ret.8
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Bat.move
0;JMP
(PongGame.run$ret.8)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push pointer 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call PongGame.moveBall 1
// push stack frame of caller
@PongGame.run$ret.9
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@PongGame.moveBall
0;JMP
(PongGame.run$ret.9)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 50
@50
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Sys.wait 1
// push stack frame of caller
@PongGame.run$ret.10
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Sys.wait
0;JMP
(PongGame.run$ret.10)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto LOOP_START4
@PongGame.run$LOOP_START4
0;JMP
//label LOOP_END4
(PongGame.run$LOOP_END4)
//goto LOOP_START5
@PongGame.run$LOOP_START5
0;JMP
//label LOOP_END5
(PongGame.run$LOOP_END5)
//push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE6
@SP
AM=M-1
D=M
@PongGame.run$FALSE6
D;JNE
//push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 27
@27
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Output.moveCursor 2
// push stack frame of caller
@PongGame.run$ret.11
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Output.moveCursor
0;JMP
(PongGame.run$ret.11)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 9
@9
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.new 1
// push stack frame of caller
@PongGame.run$ret.12
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@String.new
0;JMP
(PongGame.run$ret.12)
//push constant 71
@71
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.13
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.13)
//push constant 97
@97
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.14
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.14)
//push constant 109
@109
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.15
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.15)
//push constant 101
@101
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.16
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.16)
//push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.17
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.17)
//push constant 79
@79
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.18
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.18)
//push constant 118
@118
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.19
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.19)
//push constant 101
@101
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.20
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.20)
//push constant 114
@114
D=A
@SP
A=M
M=D
@SP
M=M+1
//call String.appendChar 2
// push stack frame of caller
@PongGame.run$ret.21
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@String.appendChar
0;JMP
(PongGame.run$ret.21)
//call Output.printString 1
// push stack frame of caller
@PongGame.run$ret.22
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Output.printString
0;JMP
(PongGame.run$ret.22)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END6
@PongGame.run$COND_END6
0;JMP
//label FALSE6
(PongGame.run$FALSE6)
//label COND_END6
(PongGame.run$COND_END6)
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
//function PongGame.moveBall 5
(PongGame.moveBall)
@SP
A=M
M=0
@SP
M=M+1
@SP
A=M
M=0
@SP
M=M+1
@SP
A=M
M=0
@SP
M=M+1
@SP
A=M
M=0
@SP
M=M+1
@SP
A=M
M=0
@SP
M=M+1
//push argument 0
@ARG
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Ball.move 1
// push stack frame of caller
@PongGame.moveBall$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Ball.move
0;JMP
(PongGame.moveBall$ret.1)
//pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//gt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE222
D;JGT
D=0
@PUSHTOSTACK222
0;JMP
(TRUE222)
D=-1
(PUSHTOSTACK222)
@SP
A=M
M=D
@SP
M=M+1
//push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push this 5
@THIS
D=M
@5
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE225
D;JEQ
D=0
@PUSHTOSTACK225
0;JMP
(TRUE225)
D=-1
(PUSHTOSTACK225)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//and
@SP
AM=M-1
D=M
A=A-1
M=M&D
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE0
@SP
AM=M-1
D=M
@PongGame.moveBall$FALSE0
D;JNE
//push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//pop this 5
@THIS
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.getLeft 1
// push stack frame of caller
@PongGame.moveBall$ret.2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Bat.getLeft
0;JMP
(PongGame.moveBall$ret.2)
//pop local 1
@LCL
D=M
@1
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.getRight 1
// push stack frame of caller
@PongGame.moveBall$ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Bat.getRight
0;JMP
(PongGame.moveBall$ret.3)
//pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Ball.getLeft 1
// push stack frame of caller
@PongGame.moveBall$ret.4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Ball.getLeft
0;JMP
(PongGame.moveBall$ret.4)
//pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Ball.getRight 1
// push stack frame of caller
@PongGame.moveBall$ret.5
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Ball.getRight
0;JMP
(PongGame.moveBall$ret.5)
//pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
//eq
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE248
D;JEQ
D=0
@PUSHTOSTACK248
0;JMP
(TRUE248)
D=-1
(PUSHTOSTACK248)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE0
@SP
AM=M-1
D=M
@PongGame.moveBall$FALSE0
D;JNE
//push local 1
@LCL
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//gt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE253
D;JGT
D=0
@PUSHTOSTACK253
0;JMP
(TRUE253)
D=-1
(PUSHTOSTACK253)
@SP
A=M
M=D
@SP
M=M+1
//push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//lt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE256
D;JLT
D=0
@PUSHTOSTACK256
0;JMP
(TRUE256)
D=-1
(PUSHTOSTACK256)
@SP
A=M
M=D
@SP
M=M+1
//or
@SP
AM=M-1
D=M
A=A-1
M=M|D
//pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE0
@SP
AM=M-1
D=M
@PongGame.moveBall$FALSE0
D;JNE
//push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push local 1
@LCL
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
//add
@SP
AM=M-1
D=M
A=A-1
M=M+D
//lt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE267
D;JLT
D=0
@PUSHTOSTACK267
0;JMP
(TRUE267)
D=-1
(PUSHTOSTACK267)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE0
@SP
AM=M-1
D=M
@PongGame.moveBall$FALSE0
D;JNE
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//neg
@SP
A=M
A=A-1
M=-M
//pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END0
@PongGame.moveBall$COND_END0
0;JMP
//label FALSE0
(PongGame.moveBall$FALSE0)
//push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
//sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
//gt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE279
D;JGT
D=0
@PUSHTOSTACK279
0;JMP
(TRUE279)
D=-1
(PUSHTOSTACK279)
@SP
A=M
M=D
@SP
M=M+1
//not
@SP
A=M
A=A-1
M=!M
//if-goto FALSE0
@SP
AM=M-1
D=M
@PongGame.moveBall$FALSE0
D;JNE
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END0
@PongGame.moveBall$COND_END0
0;JMP
//label FALSE0
(PongGame.moveBall$FALSE0)
//label COND_END0
(PongGame.moveBall$COND_END0)
//label COND_END1
(PongGame.moveBall$COND_END1)
//push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
//pop this 6
@THIS
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 0
@THIS
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Bat.setWidth 2
// push stack frame of caller
@PongGame.moveBall$ret.6
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Bat.setWidth
0;JMP
(PongGame.moveBall$ret.6)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//add
@SP
AM=M-1
D=M
A=A-1
M=M+D
//pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 7
@7
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Output.moveCursor 2
// push stack frame of caller
@PongGame.moveBall$ret.7
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Output.moveCursor
0;JMP
(PongGame.moveBall$ret.7)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Output.printInt 1
// push stack frame of caller
@PongGame.moveBall$ret.8
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@6
D=D-A
@ARG
M=D
//GOTO function
@Output.printInt
0;JMP
(PongGame.moveBall$ret.8)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END2
@PongGame.moveBall$COND_END2
0;JMP
//label FALSE2
(PongGame.moveBall$FALSE2)
//label COND_END2
(PongGame.moveBall$COND_END2)
//goto COND_END3
@PongGame.moveBall$COND_END3
0;JMP
//label FALSE3
(PongGame.moveBall$FALSE3)
//label COND_END3
(PongGame.moveBall$COND_END3)
//push this 1
@THIS
D=M
@1
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Ball.bounce 2
// push stack frame of caller
@PongGame.moveBall$ret.9
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// reposition ARG and LCL pointers
@SP
D=M
@LCL
M=D
@7
D=D-A
@ARG
M=D
//GOTO function
@Ball.bounce
0;JMP
(PongGame.moveBall$ret.9)
//pop temp 0
@TEMP
D=A
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
//goto COND_END4
@PongGame.moveBall$COND_END4
0;JMP
//label FALSE4
(PongGame.moveBall$FALSE4)
//label COND_END4
(PongGame.moveBall$COND_END4)
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//return
@LCL
D=M
@R13
M=D  // R13 now stores the base of the frame
@5
A=D-A
D=M
@R14
M=D   // R14 now stores the return address
// add return value of the caller to arg0 in ARG_segment
@SP
AM=M-1
D=M
@ARG
A=M
M=D
// change value of stack pointer for caller
@ARG
D=M
@SP
M=D+1
// restore base addresses of caller
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M  // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
// end loop
(END)
@END
0;JMP
