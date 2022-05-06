First name, Last name, ID: ….....ABDULLAH HASSAN.......................................................

Question 1 (4 points)

Let consider the Branch Prediction Mechanism based on the Branch History Table (BHT).
You are requested to
1.	Describe the architecture of a BHT
2.	Describe the behavior of a BHT, detailing when the processor accesses it, how, and which information it gets from it
3.	Assuming that the processor uses 32 bit addresses, each instruction is 4 byte wide, and the BHT is composed of 8 entries, identify the final content of the BHT if
•	The BHT is initially empty (i.e., full of 0s, meaning NotTaken)
•	The following instructions are executed in sequence (for each instruction the correspond-ing address is reported)
◦	0x00A60250	l.d r2,v1(r1)	
◦	0x00A60254	bnez r2,l1  (branch taken, jumping to 0x00008000)
◦	0x00008000	addi r2, r2, #1 	
◦	0x00008004	bez r2, l2	(branch not taken)
◦	0x00008008	andi r5, r5, #1
◦	0x0000800C	bez r5, l3  (branch taken, jumping to 0x00009010)
◦	0x00009010	add r1, r2,r3 	
◦	0x00009014 	bez r1, l4  (branch taken, jumping to 0x00009200)
◦	0x00009200	add r4, r5 r0
◦	0x00009204	bez r4, l1	(branch taken, jumping to 0x00008000)
	Determine also which of the branch instructions were correctly predicted, and which were mispredicted.

Write your answer here.
Branch history table is  harware structure which contain the lower bits of branch instruction as an index and record one or more bit wheteher the branch is taken or not  .
 when an entery is made in branch history table it made prediction on the basis of   
and previous executed  instruction.
Address	bits
1	0
2	
3 0x00009010	1
4 0x00008000	1
5 0x00008000	1
6	
7	
8	

Question 2 (4 points)

Let consider a MIPS64 architecture including the following functional units (for each unit the number of clock periods to complete one instruction is reported):
•	Integer ALU: 1 clock period
•	Data memory: 1 clock period
•	FP arithmetic unit: 2 clock periods (pipelined)
•	FP multiplier unit: 4 clock periods (pipelined)
•	FP divider unit: 8 clock periods (unpipelined)
You should also assume that
•	The branch delay slot corresponds to 1 clock cycle, and the branch delay slot is not enabled
•	Data forwarding is enabled
•	The EXE phase can be completed out-of-order.

You should consider the following code fragment and, filling the following tables, determine the pipeline behavior in each clock period, as well as the total number of clock periods required to execute the fragment, assuming that f5 is always different than 0. The values of the constants k1 and k2 are written in f10 and f11 before the beginning of the code fragment.

; ********************* MIPS64 ***********************
;  for (i = 0; i < 10; i++) {
;	  tmp = v1[i]*k1 + v2[i]*k2;
	  if (tmp!=0)
		v3[i]=tmp;
;  }
		.data	Comments	Clock cycles
v1:	.double “10 values”		
v2:	.double “10 values”		
v3:	.double “10 values”		
		
		.text		
main:  daddui r1,r0,0	r1← pointer	5
	daddui r2,r0,10	r2 <= 10	1
loop:   l.d  f1,v1(r1)	f1 <= v1[i]	1
	l.d  f2,v2(r1)	f2 <= v2[i]	1
	mul.d  f3, f1, f10	f3 <= v1[i]*k1	4
	mul.d  f4, f2, f11	f4 <= v2[i]*k2	1
	add.d f5, f3, f4	f5 <= v1[i]*k1 + v2[i]*k2	2
	beq f5, error	if( f5==0) goto error	2
	s.d  f5,v3(r1)	v3[i] <= f5	1
	daddui  r1,r1,8	r1 <= r1 + 8	1
	daddi  r2,r2,-1	r2 <= r2 - 1  	1
	bnez  r2,loop		2
	halt		1
				total		(17*10)+6=176

main:  daddui r1,r0,0	F	D	E	M	W		5																					
	daddui r2,r0,10	F	D	E	M	W		1																					
loop:   l.d  f1,v1(r1)		F	D	E	M	W	1																					
	l.d  f2,v2(r1)			F	D	E	M	W	1																				
	mul.d  f3, f1, f10				F	D	E	E	E	E	M	W																	
	mul.d  f4, f2, f11					F	D	E	E	E	E	M	W																
	add.d f5, f3, f4	2					F	D				E	E	M	w														
	beq f5, error	2						F						d	e	m	w												
	s.d  f5,v3(r1)	1												f	d	e	m	w											
	daddui  r1,r1,8	1													f	d	e	m	w										
	daddi  r2,r2,-1	1														f	d	e	m	w									
	bnez  r2,loop	2															f		d	e	m	w							
	halt	1																	f	d	e	m	w						

Question 3 (8 points)

In the fixed-point representation, a fixed number of digits is used to represent the fractional part of a number. Example of fixed-point number with 8 fractional digits: 101.10011101. The corresponding decimal value is 1 * 22 + 0 * 21 + 1 * 20 + 1 * 2-1 + 0 * 2-2 + 0 * 2-3 +1 * 2-4 + 1 * 2-5 +1 * 2-6 + 0 * 2-7 + 1 * 2-8 = 4 + 0 + 1 + 0.5 + 0 + 0 + 0.0625 + 0.03125 + 0.015625 + 0 + 0.00390625 = 5.61328125

Write the computeF subroutine in ARM assembly language, which computes the following function: f(x, y) = (x + y/x) / 2.
The subroutine receives in input:
1.	x: a 32-bit value which represents an unsigned fixed-point number
2.	n: the number of fractional digits in x
3.	y: a 32-bit value which represents another unsigned fixed-point number
4.	m: the number of fractional digits in y

The subroutine returns f(x, y), with a number of fractional digits equal to max(n, m).

Let a be the number of fractional digits of the dividend, b the number of fractional digits of the divisor, and c the position of the leftmost bit set to 1 in the dividend (the bits are counted from left to right, i.e., the most significant bit is at position 0). First of all, in order to increase the precision of the division, the dividend must be shifted left by c positions (in this way, the most significant bit is set to 1). Then, the result of the division between the two fixed-point numbers is computed as the integer quotient of their underlying integers. The number of fractional digits of the result is d = a + c – b.

In order to add two fixed-point numbers, they must have the same number of fractional digits. If the number of fractional digits is different, the fixed-point number with few fractional digits must be shifted left by a proper number of positions.

It is suggested to implement the division by 2 with a right shift.

Example: x = 0.11, n = 2, y = 101.001, m = 3.
The '.' separating integer and fractional digits is shown only for the sake of clarity.

Step 1: division.
a = 3, b = 2, c = 26.
y is shifted left by 26 positions
10100100000000000000000000000000 / 11 = 110110101010101010101010101010
d = 3 + 26 – 2 = 27: the corresponding fixed-point number is 110.110101010101010101010101010

Step 2: addition.
n < d, so x is shifted left by d – n = 25 position.
0.110000000000000000000000000 + 110.110101010101010101010101010 =
	= 111.100101010101010101010101010

Step 3: the division by 2 gives 11.110010101010101010101010101
The result is approximated to max(n, m) = 3 fractional digits: the subroutine returns 11.110


Important notes:
1.	Create a new project with Keil inside the “ARM” directory and write your code there.
2.	The assembly subroutine must comply with the ARM Architecture Procedure Call Standard (AAPCS) standard (about parameter passing, returned value, callee-saved registers).
3.	Click on the following links to open web pages with the ARM instruction set
http://www.keil.com/support/man/docs/armasm
https://developer.arm.com/documentation/ddi0337/e/Introduction/Instruction-set-summary?lang=en
4.	You can convert fixed-point numbers from/to base 2 and 10 at this link:
https://www.exploringbinary.com/binary-converter/


Question 4 (5 points)
The subroutine developed in the previous exercise can be called iteratively to compute the square root of a number y. In this exercise, we want to compute the square root of y = 2022.
1)	In a data area, allocate space for:
- numIteration: a 32-bit variable
- arrayF: an array of 10 elements; each element is a word (32 bits)

Inizialize numIteration to 0 and the first element of arrayF to 1, to be represented as a fixed-point value with 12 fractional digits. The other elements are not initialized.
2)	In the Reset_Handler, configure the SYSTICK timer in order to generate an interrupt every 220 clock cycles. Then, enter in an infinite loop.

The SYSTICK timer is configured by means of the following registers:
- Control and Status Register: size 32 bits, address 0xE000E010
- Reload Value Register: size 24 bits, address 0xE000E014
- Current Value Register: 24 bits, address 0xE000E018

The meaning of the bits in the Control and Status Register is as follows:
- Bit 16 (read-only): it is read as 1 if the counter reaches 0 since last time this register is read; it is cleared to 0 when read or when the current counter value is cleared
- Bit 2 (read/write): if 1, the processor free running clock is used; if 0, an external reference clock is used
- Bit 1 (read/write): if 1, an interrupt is generated when the timer reaches 0; if 0, the interrupt is not generated
- Bit 0 (read/write): if 1, SYSTICK timer is enabled; if 0, SYSTICK timer is disabled.

The Reload Value Register stores the value to reload when the timer reaches 0.
The Current Value Register stores the current value of the timer. Writing any number clears its content.
3)	In the handler of the SYSTICK timer, read the value of numIteration stored in memory. It counts the number of times the computeF subroutine has been called so far. Get the value k of the element of arrayF at position numIteration. Call the computeF subroutine with the following parameters: x = k, n = 12, y = 2022, m = 0.
Increment numIteration by 1 and save the new result in memory.
Get the value returned by computeF and save it in arrayF at position numIteration (after the increment, this is the first empty element of the array).
Note that the computeF subroutine has to be called 10 times (at 10 different SYSTICK timer interrupts) because this is the lenght of arrayF. At the end, the last element of arrayF stores the best approximation of the square root of 2022.

Question 5 (6 points)

Given a 3 x 4 matrix of bytes SOURCE representing two's complement numbers on 8 bits each one, write an 8086 assembly program which changes the sign of each element and transposes the matrix, i.e. reverses the columns and rows from SOURCE to DESTINATION, i.e.:
DESTINATION (i, j) = - SOURCE (j,i)
•	SOURCE has 3 rows and 4 columns and the transposed DESTINATION has 4 rows and 3 columns
•	Both SOURCE and DESTINATION are "cut" by rows to be mapped to the 8086 data memory
•	It is known in advance that the absolute value of each element of SOURCE does not exceed 120
•	BRUTE FORCE APPROACH (i.e., without "loops") IS NOT ACCEPTABLE
•	In your solution, please provide the declaration of SOURCE and DESTINATION, the code, and significant comments to the code and instructions. The class program does not include input output, while the home code should include input of SOURCE and printing of DESTINATION
•	HINT: cut by rows the two matrices SOURCE (a..l) and DESTINATION found below and depict the  corresponding 8086 data memory mapping organizations; then find an algorithm to switch from the 8086 data memory mapping of SOURCE to that of DESTINATION
•	The single-loop-smart-algorithm is eligible to get up to one extra point (do not ask what is this algorithm)

Write your code in a file saved in the 8086 folder.

Example (where a, ..., l represent 2's complement numbers in the range -120...+120)

SOURCE
a	b	c	d
e	f	g	h
i	j	k	l

the following matrix DESTINATION is computed
-a	-e	-i
-b	-f	-j
-c	-g	-k
-d	-h	-l
**

Initial matrix SOURCE
1	2	-3	4	
-5	6	-7	8	
-9	0	3	-1

the following matrix DESTINATION is computed
-1	5	9
-2	-6	0
3	7	-3
-4	-8	1

Click on the following link to open a web page with the 8086 instruction set:
http://www.jegerlehner.ch/intel/IntelCodeTable.pdf
