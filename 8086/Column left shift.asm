.MODEL small
.STACK

.DATA

S  DB  'A','E','I','M'
   DB  'B','F','J','N'
   DB  'C','G','K','O'
   DB  'D','H','L','P'
        
D  DB  16  DUP(?)           

n   DW 69

.CODE
.STARTUP

MOV AX,011b
AND AX,n
MOV BX,4
SUB BX,AX
MOV AL,4
MUL BL

MOV DI,AX

MOV CX,16
CYCLE:
    MOV AL,S[SI]
    CMP DI,16
    JNE skip
    AND DI,0
    skip:
    MOV D[DI],AL
    INC SI
    INC DI 
loop    CYCLE

.EXIT
END