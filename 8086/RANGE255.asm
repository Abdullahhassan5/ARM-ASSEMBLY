.MODEL SMALL
.STACK
.DATA

SOURCE DW 10 ,20, 100, 10000 ,0	,7000, 1, 2, 9000, 12345, 999, 30000,  200 ,210 ,7, 65000

MAP DB 16 DUP(?)


CROSS DW 0

.CODE
.STARTUP

MOV AX , 0
MOV BX , 0 
MOV CX , 16
MOV SI , 0 
MOV DI , 0 

LOOP1:
MOV AX , SOURCE[BX]  



CMP CX ,0
JE EXIT
 

CMP AH , 0

JE LABLE1
JNE LABLE2


 



LABLE1:
MOV MAP[SI] , 1

ADD CROSS, AX

INC SI 

ADD BX , 2 

DEC CX
CMP CX ,0
JE EXIT
JNE LOOP1

LABLE2:

MOV MAP[SI] , 0
INC SI


ADD BX , 2 

DEC CX
CMP CX ,0
JE EXIT
JNE LOOP1 


EXIT:

.EXIT
END