.MODEL SMALL
.STACK
.DATA
SOURCE DW 1,2,3,4,5,6,7,8,9,0,9,8,7,6,5,4,3,2,1,0,7,7,7,7,7

DRESULT DW 0
RESULT DW 0





.CODE
.STARTUP
MOV BX , 0 
MOV CX, 5  
MOV DI , 0
MOV SI , 0
MOV AX , 0
MOV DX , 0
LOOP1:
MOV AX , SOURCE[BX]

ADD DX , AX

MOV DRESULT , DX

MOV SOURCE[BX] , 0

ADD BX , 12




DEC CX
CMP CX , 0 

JE EXIT
JNE LOOP1
EXIT: 

MOV DX , 0
MOV AX , 0 
MOV BX , 0  
MOV CX , 25

LOOP2:
MOV AX , SOURCE[BX]

ADD DX , AX

MOV RESULT , DX
ADD BX , 2
DEC CX   



CMP CX , 0
JE EXIT2
JNE LOOP2

EXIT2:
MOV AX ,  0
MOV AX , DRESULT
SUB RESULT , AX




.EXIT
END