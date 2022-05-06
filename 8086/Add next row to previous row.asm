.MODEL small
.STACK

.DATA

S  DB  1,2,3
   DB  4,5,6
   DB  7,8,9
        
D  DB  9  DUP(?)           

.CODE
.STARTUP
        
MOV DI,3        
MOV CX,9
CYCLE:
    MOV AL,S[SI]
    CMP DI,9
    JNE here
    AND DI,0
    here:
    MOV BL,S[DI]
    ADD AL,BL
    MOV D[SI],AL
    INC SI
    INC DI
loop    CYCLE

.EXIT
END