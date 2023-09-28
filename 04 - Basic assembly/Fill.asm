// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

(BLACKLOOP) 	   //Fills every pixel when key is pressed
@24576		        //Keyboard register
D=M		           //Keyboard register memory set to D
@WHITELOOP	     //Goes to white loop if jump specification met
D;JEQ		         //Jump, Goes to white loop if Keyboard memory register = 0
@24575		       //@screen's last pixel
D=M		           //@screen's last pixel memory set to D
@WHITELOOP	     //Goes to white loop if jump specification met
D;JLT		         //Jump, Goes to white loop if last pixel is filled, so not to exceed register amount
@i		          //i, some register
D=M		         //i memory set to D
@16384		      //@screen's first pixel
D=A+D		       //Register = @screen + i
A=D		         //Register set
M=-1		        //Register memory set to -1, fills all pixels in 16-bit register
@i		        //i, some register
M=M+1		       //Increments i's memory, which starts at zero
@BLACKLOOP	   //Goes back to beginning of loop
0;JMP		       //Null Jump, go back to black loop

(WHITELOOP)	    //Removes every pixel when key is not pressed
@24576		      //Keyboard Register
D=M		           //Keyboard Register memory set to D
@BLACKLOOP	     //Goes to black loop if jump specification met
D;JGT		       //Jump, Goes to black loop if Keyboard memory register = 1
@i		        //i, some register
D=M		         //i memory set to D
@16384		  //@screen's first pixel
D=A+D		     //Register = @screen + i
A=D		     //Register set
M=0		       //Register memory set to 0, removes all filled pixels in 16-bit register
@i		    //i, some register
M=M-1		   //De-increments i's memory, which if the key has been pressed, has been raised to some number
@WHITELOOP	//Goes back to beggining of loop
0;JMP		     //Null Jump, go back to white loop