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
// function Sys.init 0
(Sys.init)

// push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// call Sys.main 0
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
@5
D=D-A
@ARG
M=D
//goto function
@Sys.main
0;JMP
(Sys.init$ret.1)
// pop temp 1
@5
D=A
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
// label LOOP
(Sys.init$LOOP)
// goto LOOP
@Sys.init$LOOP
0;JMP
// function Sys.main 5
(Sys.main)

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
// push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 1
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
// push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 2
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
// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 3
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
// push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Sys.add12 1
// push stack frame of caller
@Sys.main$ret.1
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
@Sys.add12
0;JMP
(Sys.main$ret.1)
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
// push local 2
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
// push local 3
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
// push local 4
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
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
// add
@SP
AM=M-1
D=M
A=A-1
M=M+D
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
// function Sys.add12 0
(Sys.add12)

// push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
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
// push constant 12
@12
D=A
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
// end loop
(END)
@END
0;JMP