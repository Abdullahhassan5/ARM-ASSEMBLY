.MODEL SMALL 
.STACK
.DATA

SOURCE  DB 1, 2,3,4, 5, 6
SOURCE2 DB 10,11,20,21,30,3

;1 2 3   
;4 5 6
;7 8 9 


         ;5 7 9
         ;11 13 15
         ;8 10 12

DEST DW 4 DUP(?)
RESULT DW 0


.CODE
.STARTUP
MOV BX , 0 
MOV AX , 0
MOV CX , 0
MOV SI , 0 
MOV DI , 0

MOV DX , 0
loop1:

MOV AL , SOURCE[SI]
MOV BL , SOURCE2[DI]

MUL BL

ADD DX , AX  
 
MOV RESULT , DX 

INC SI

ADD DI , 2  
INC CX
CMP CX , 3
JE LABLE1

CMP CX , 6
JE LABLE2




CMP CX , 9
JE LABLE3


CMP CX , 12
JE EXIT
JNE LOOP1

LABLE1:  
MOV SI , 0 
MOV DEST[SI]   , DX 
MOV DX , 0 

MOV DI , 1
JMP LOOP1

LABLE2:
MOV SI , 2
MOV DEST[SI], DX 
MOV SI , 3
MOV DI , 0
MOV DX , 0 
JMP LOOP1

LABLE3:

MOV SI , 4
MOV DEST[SI], DX
MOV SI , 3
MOV DI , 1 
MOV DX , 0  

JMP LOOP1





EXIT: 

MOV SI , 6
MOV DEST[SI], DX


.EXIT
END