.MODEL SMALL
.STACK
ROW EQU 5
COL EQU 5

SIZE EQU 5*5



.DATA

SOURCE DB 1,2,3,4,5,6,7,8,9,0,9,8,7,6,5,4,3,2,1,0,7,7,7,7,7 ;CUT BY ROW

SALL DW ? 
FINAL DW ?
DIG DW ?


.CODE 
.STARTUP
XOR AX, AX 
XOR BX , BX
XOR SI , SI
XOR DI , DI 
XOR CX , CX 
LABLE1:
MOV AL , SOURCE[SI]

ADD DIG , AX

MOV SOURCE[SI] , BL 

ADD SI , 6
INC CX
CMP CX , 5
JNE LABLE1

XOR AX ,AX
XOR BX , BX 
XOR SI , SI
XOR DI , DI
MOV CX , SIZE

LABLE2:

MOV AL , SOURCE[SI]
ADD SALL , AX

INC SI 

LOOP LABLE2

MOV AX , SALL
MOV BX , DIG
SUB AX , BX
MOV FINAL , AX 




.EXIT
END