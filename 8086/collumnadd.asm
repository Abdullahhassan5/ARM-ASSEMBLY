.MODEL SMALL
.STACK
.DATA
SOURCE DB 1,2,3,4,5,6, 7,8,9
        
      
       
DEST DB 9 DUP(?)

COPY DB 1, 4 , 7       





.CODE
.STARTUP

MOV AX, 0 
MOV BX, 0
MOV DX ,0
MOV SI ,0
MOV CX ,0
MOV DI ,1


LOOP1:

MOV AL , SOURCE[SI]

MOV BL , SOURCE[DI] 

ADD AX , BX  

MOV DEST[SI] , AL

ADD SI , 3

ADD DI , 3

ADD DX , 3 


INC CX 

CMP CX , 3
JE LABLE1


CMP CX , 6
JE LABLE2  



CMP CX , 9   
JE EXIT      
JNE LOOP1 


LABLE1:

MOV SI , 1
MOV DI , 2
JMP LOOP1

LABLE2:


MOV SI , 0 
MOV DI , 2 
MOV AX , 0 
MOV BX , 0 
LABLE3:
MOV AL , COPY[SI]
MOV BL , SOURCE[DI]

ADD AX , BX 

MOV DEST[DI] , AL

ADD DI , 3

INC SI

CMP SI , 3
JNE LABLE3




EXIT:
.EXIT
END
