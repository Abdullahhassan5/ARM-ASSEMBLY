.MODEL small
.STACK
.DATA
      
N   EQU  4
M   EQU  7
P   EQU  5 

DP  DW  0

A   DB 3,14,-15,9,26,-53,5
    DB 89,79,3,23,84,-6,26
    DB 43,-3,83,27,-9,50,28
    DB -88,41,97,-103,69,39,-9

B   DB 37,-101,0,58,-20
    DB 9,74,94,-4,59
    DB -23,90,-78,16,-4
    DB 0,-62,86,20,89
    DB 9,86,28,0,-34
    DB 82,5,34,-21,1
    DB 70,-67,9,82,14 
        
C   DW  N*P DUP(?)        

.CODE
.STARTUP
        
AND SI,0 
AND DI,0 

MOV CX,N
loop1:
  
PUSH    CX
    MOV CX,P 
    loop2:       
    
    PUSH    CX        
        MOV CX,M 
        AND DX,0
        loop3:
            MOV AL,A[SI]
            MOV BL,B[DI]
            IMUL    BL
            ADD DX,AX
            JNO here
            MOV DX,07FFFh
            here:
            INC SI
            ADD DI,P
        loop    loop3
        SUB SI,M
        SUB DI,M*P 
        INC DI
        MOV BX,DP
        MOV C[BX],DX
        ADD DP,2
    POP CX    
    loop    loop2 
    
    ADD SI,M
    AND DI,0
POP CX
loop    loop1        



.EXIT
END
