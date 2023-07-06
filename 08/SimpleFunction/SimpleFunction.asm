// function SimpleFunction.test 2
(SimpleFunction.test)
@2
D=A
(CHECK)
@FINISH_FUNC_INIT
D;JEQ
@SP
A=M
M=0
@SP
M=M+1
D=D-1
@CHECK
0;JMP
(FINISH_FUNC_INIT)
// push local 0
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
// push local 1
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
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
// not
@SP
A=M
A=A-1
M=!M
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
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
// push argument 1
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
// sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
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
AMD=M-1
D=M   // D = *(FRAME - (i+1))
@THAT
M=D
@R13
AMD=M-1
D=M   // D = *(FRAME - (i+1))
@THIS
M=D
@R13
AMD=M-1
D=M   // D = *(FRAME - (i+1))
@ARG
M=D
@R13
AMD=M-1
D=M   // D = *(FRAME - (i+1))
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