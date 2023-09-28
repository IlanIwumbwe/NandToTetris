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
// function Class1.set 0
(Class1.set)

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
// pop static 0
@SP
AM=M-1
D=M
@Class1.0
M=D
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
// pop static 1
@SP
AM=M-1
D=M
@Class1.1
M=D
// push constant 0
@0
D=A
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
// function Class1.get 0
(Class1.get)

// push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class1.1
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
// function Class2.set 0
(Class2.set)

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
// pop static 0
@SP
AM=M-1
D=M
@Class2.0
M=D
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
// pop static 1
@SP
AM=M-1
D=M
@Class2.1
M=D
// push constant 0
@0
D=A
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
// function Class2.get 0
(Class2.get)

// push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class2.1
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

// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Class1.set 2
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
@7
D=D-A
@ARG
M=D
//goto function
@Class1.set
0;JMP
(Sys.init$ret.1)
// pop temp 0
@5
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
// push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Class2.set 2
// push stack frame of caller
@Sys.init$ret.2
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
//goto function
@Class2.set
0;JMP
(Sys.init$ret.2)
// pop temp 0
@5
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
// call Class1.get 0
// push stack frame of caller
@Sys.init$ret.3
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
@Class1.get
0;JMP
(Sys.init$ret.3)
// call Class2.get 0
// push stack frame of caller
@Sys.init$ret.4
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
@Class2.get
0;JMP
(Sys.init$ret.4)
// label WHILE
(Sys.init$WHILE)
// goto WHILE
@Sys.init$WHILE
0;JMP
// end loop
(END)
@END
0;JMP