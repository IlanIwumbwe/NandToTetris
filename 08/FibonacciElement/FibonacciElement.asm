// bootstrap code, set SP=256, and call Sys.init
@256
D=A
@SP
M=D
// push stack frame of caller
@$ret
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
($ret)
// function Main.fibonacci 0
(Main.fibonacci)
@-1
D=A
(CHECK)
@FINISH_FUNC_INIT
D;JLT
@SP
A=M
M=0
@SP
M=M+1
D=D-1
@CHECK
0;JMP
(FINISH_FUNC_INIT)
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
D=A
@LCL
A=M-D
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
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
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
@Main.fibonacci$ret
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
(Main.fibonacci$ret)
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
@Main.fibonacci$ret
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
(Main.fibonacci$ret)
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
D=A
@LCL
A=M-D
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
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
// jump to return address, giving control back to caller
@R14
A=M
0;JMP
// function Sys.init 0
(Sys.init)
@-1
D=A
(CHECK)
@FINISH_FUNC_INIT
D;JLT
@SP
A=M
M=0
@SP
M=M+1
D=D-1
@CHECK
0;JMP
(FINISH_FUNC_INIT)
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
@Sys.init$ret
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
(Sys.init$ret)
// label WHILE
(Sys.init$WHILE)
// goto WHILE
@Sys.init$WHILE
0;JMP
// end loop
(END)
@END
0;JMP