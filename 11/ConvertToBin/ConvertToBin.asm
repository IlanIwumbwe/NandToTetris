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
//function Main.main 1
(Main.main)
@SP
A=M
M=0
@SP
M=M+1
//push constant 8001
@8001
D=A
@SP
A=M
M=D
@SP
M=M+1
//push constant 16
@16
D=A
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
//neg
@SP
A=M
A=A-1
M=-M
//call Main.fillMemory 3
// push stack frame of caller
@Main.main$ret.1
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
@Main.fillMemory
0;JMP
(Main.main$ret.1)
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
//push constant 8000
@8000
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Memory.peek 1
// push stack frame of caller
@Main.main$ret.2
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
@Memory.peek
0;JMP
(Main.main$ret.2)
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
//call Main.convert 1
// push stack frame of caller
@Main.main$ret.3
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
@Main.convert
0;JMP
(Main.main$ret.3)
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
//function Main.convert 3
(Main.convert)
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
//label LOOP_START0
(Main.convert$LOOP_START0)
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
//not
@SP
A=M
A=A-1
M=!M
//if-goto LOOP_END0
@SP
AM=M-1
D=M
@Main.convert$LOOP_END0
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
//call Main.nextMask 1
// push stack frame of caller
@Main.convert$ret.1
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
@Main.nextMask
0;JMP
(Main.convert$ret.1)
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
//push constant 16
@16
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
@TRUE32
D;JGT
D=0
@PUSHTOSTACK32
0;JMP
(TRUE32)
D=-1
(PUSHTOSTACK32)
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
@Main.convert$FALSE0
D;JNE
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
//and
@SP
AM=M-1
D=M
A=A-1
M=M&D
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
@TRUE40
D;JEQ
D=0
@PUSHTOSTACK40
0;JMP
(TRUE40)
D=-1
(PUSHTOSTACK40)
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
@Main.convert$FALSE0
D;JNE
//push constant 8000
@8000
D=A
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
//add
@SP
AM=M-1
D=M
A=A-1
M=M+D
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Memory.poke 2
// push stack frame of caller
@Main.convert$ret.2
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
@Memory.poke
0;JMP
(Main.convert$ret.2)
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
//goto COND_END0
@Main.convert$COND_END0
0;JMP
//label FALSE0
(Main.convert$FALSE0)
//push constant 8000
@8000
D=A
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
//add
@SP
AM=M-1
D=M
A=A-1
M=M+D
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Memory.poke 2
// push stack frame of caller
@Main.convert$ret.3
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
@Memory.poke
0;JMP
(Main.convert$ret.3)
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
//label COND_END0
(Main.convert$COND_END0)
//goto COND_END1
@Main.convert$COND_END1
0;JMP
//label FALSE1
(Main.convert$FALSE1)
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
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
//label COND_END1
(Main.convert$COND_END1)
//goto LOOP_START2
@Main.convert$LOOP_START2
0;JMP
//label LOOP_END2
(Main.convert$LOOP_END2)
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
//function Main.nextMask 0
(Main.nextMask)
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
@TRUE71
D;JEQ
D=0
@PUSHTOSTACK71
0;JMP
(TRUE71)
D=-1
(PUSHTOSTACK71)
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
@Main.nextMask$FALSE0
D;JNE
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//goto COND_END0
@Main.nextMask$COND_END0
0;JMP
//label FALSE0
(Main.nextMask$FALSE0)
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
//push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//call Math.multiply 2
// push stack frame of caller
@Main.nextMask$ret.1
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
@Math.multiply
0;JMP
(Main.nextMask$ret.1)
//label COND_END0
(Main.nextMask$COND_END0)
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
//function Main.fillMemory 0
(Main.fillMemory)
//label LOOP_START0
(Main.fillMemory$LOOP_START0)
//push argument 1
@ARG
D=M
@1
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
@TRUE86
D;JGT
D=0
@PUSHTOSTACK86
0;JMP
(TRUE86)
D=-1
(PUSHTOSTACK86)
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
//if-goto LOOP_END0
@SP
AM=M-1
D=M
@Main.fillMemory$LOOP_END0
D;JNE
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
//push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
//call Memory.poke 2
// push stack frame of caller
@Main.fillMemory$ret.1
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
@Memory.poke
0;JMP
(Main.fillMemory$ret.1)
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
//push argument 1
@ARG
D=M
@1
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
//sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
//pop argument 1
@ARG
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
//pop argument 0
@ARG
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
//goto LOOP_START0
@Main.fillMemory$LOOP_START0
0;JMP
//label LOOP_END0
(Main.fillMemory$LOOP_END0)
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
