.MODEL small
.STACK
.DATA

S   DW  'A','B','C','D'
    DW  'E','F','G','H'
    DW  'I','J','K','L'
    DW  'M','N','O','P'

D   DW  16  DUP(?)

N   DW  420  

.CODE
.STARTUP

MOV AX,N
AND AX,011b
MOV BL,8
MUL BL
MOV DI,AX          
MOV CX,16
CYCLE:
    MOV AX,S[SI]
    CMP DI,32
    JNE here
    AND DI,0
    here:
    MOV D[DI],AX  
    ADD SI,2
    ADD DI,2
loop    CYCLE


.EXIT
END