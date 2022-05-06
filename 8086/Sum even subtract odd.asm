.MODEL small
.STACK

.DATA

S  DB   1,2,3,4,5
   DB   6,7,8,9,0
   DB   9,8,7,6,5
   DB   4,3,2,1,0
   DB   7,7,7,7,7
   DB   3,5,7,9,0
   DB   8,7,6,5,4
   DB   9,9,9,3,2
        
D  DW  0           

.CODE
.STARTUP 

AND AX,0
AND DX,AX
MOV CX,20
CYCLE:
    MOV AL,S[SI]
    ADD DX,AX
    MOV AL,S[SI+1]
    SUB DX,AX
    ADD SI,2
loop    CYCLE 
MOV D,DX

.EXIT
END