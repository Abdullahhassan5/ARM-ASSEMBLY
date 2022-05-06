.MODEL small
.STACK

.DATA

S  DB   1,2,3,4,5
   DB   6,7,8,9,0
   DB   9,8,7,6,5
   DB   4,3,2,1,0
   DB   7,7,7,7,7
        
D  DW  0           

.CODE
.STARTUP

AND AX,0 
AND DX,0
MOV CX,25        
CYCLE1:
    MOV DL,S[SI]
    ADD AX,DX
    INC SI
loop    CYCLE1

AND BX,0
AND DX,0
MOV CX,5
CYCLE2:
    MOV DL,S[DI]
    ADD BX,DX
    ADD DI,6
loop    CYCLE2

SHL BX,1
SUB AX,BX
MOV D,AX


.EXIT
END