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
//goto function
@Sys.init
0;JMP
($ret.0)
// function Main.fibonacci 0
(Main.fibonacci)

// push argument 0
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
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// lt
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@TRUE3
D;JLT
D=0
@PUSHTOSTACK3
0;JMP
(TRUE3)
D=-1
(PUSHTOSTACK3)
@SP
A=M
M=D
@SP
M=M+1
// if-goto IF_TRUE
@SP
AM=M-1
D=M
@Main.fibonacci$IF_TRUE
D;JNE
// goto IF_FALSE
@Main.fibonacci$IF_FALSE
0;JMP
// label IF_TRUE
(Main.fibonacci$IF_TRUE)
// push argument 0
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
// return
@LCL
D=M
@R13
M=D   // R13 now stores the base of the frame
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
D=M   // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
// label IF_FALSE
(Main.fibonacci$IF_FALSE)
// push argument 0
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
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
// call Main.fibonacci 1
// push stack frame of caller
@Main.fibonacci$ret.1
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
//goto function
@Main.fibonacci
0;JMP
(Main.fibonacci$ret.1)
// push argument 0
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
// push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
// call Main.fibonacci 1
// push stack frame of caller
@Main.fibonacci$ret.2
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
//goto function
@Main.fibonacci
0;JMP
(Main.fibonacci$ret.2)
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
// return
@LCL
D=M
@R13
M=D   // R13 now stores the base of the frame
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
D=M   // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AM=M-1
D=M   // D = *(FRAME - (i+1))
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
// function Sys.init 0
(Sys.init)

// push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Main.fibonacci 1
// push stack frame of caller
@Sys.init$ret.1
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
//goto function
@Main.fibonacci
0;JMP
(Sys.init$ret.1)
// label WHILE
(Sys.init$WHILE)
// goto WHILE
@Sys.init$WHILE
0;JMP
// end loop
(END)
@END
0;JMP