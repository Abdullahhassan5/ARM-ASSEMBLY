;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF
				
				
				AREA matrixDeclaration, DATA, READWRITE
matrix 			SPACE 2000 
				
				AREA arrayInitialization, DATA, READONLY
array 			DCD 4, 30, 120, 340, 780

                AREA    |.text|, CODE, READONLY
arraynum EQU 5	; number of values in the array
Constant1 EQU 0x7FFFFFFF
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
;                IMPORT  SystemInit
;                IMPORT  __main
;                LDR     R0, =SystemInit
;                BLX     R0
;                LDR     R0, =__main
;                BX      R0
				LDR r0, =matrix
				LDR r1, =array
				LDR r2, =arraynum 
				
				BL initializeMatrix
				
				LDR r0, =matrix
				LDR r1, =arraynum 
				BL computeDifferences
				
				LDR r0, =matrix
				LDR r1, =arraynum 
				BL getPolynomialValue
				
stop			B stop				
				ENDP


getPolynomialValue PROC

				PUSH {LR}
				
				
				MOV R2, R0 			;copying index of matrix
				
				SUB R3, R1, #1
				
lpg				ADD R2, #4			; index of last column firt row
				SUB R3, #1
				CMP R3, #0
				BNE lpg
				
				LDR R3, [R2]		; value of M[0][N]
				SUB R5, R1, #1			
				MUL R4, R5, R1			
				
lpg1			ADD R2, R4			; Index of M[I][N]
				STR R3, [R2]
				SUB R5, #1
				CMP R5, #0
				BNE lpg1
				; last column filled with the first value of last colum
				
				;second last column
				SUB R3, R1, #1		;R3 containd 4
				ADD R2, R0, R4		; R4 contains 20	 
				ADD R2, R2, R4
				ADD R2, R2, R3
				ADD R2, R2, R3
				ADD R2, R2, R3		;R2 points to index M[2][n-1]
				
				MOV R5, R2		
				MOV R10, R3			; counter for the column decrement with 1 row increment
				
				
lpg3				MOV R9, R3			;counter for each column loop where row increments
lpg2			SUB R6, R5, R4		;R6 points to the value above R2 index
				LDR R7, [R6]
				ADD R6, R3			; R6 now points to value next to to above R6
				LDR R8, [R6]
				ADD R7, R8, R7
				
				STR R7, [R5]
				
				ADD R5, R4
				
				SUB R9, #1
				CMP R9, #0
				BNE lpg2
				
				SUB R5, R5, R4
				SUB R5, R5, R4
				SUB R5, R5, R4
				SUB R5, R5, R3
				
				SUB R10, #1			; Decrement outer counter
				CMP R10, #0			
				BNE lpg3
				
				
				ADD R5, R5, R4
				ADD R5, R5, R4
				ADD R5, R5, R3
				
				LDR R2, [R5]
				
				POP {PC}
				ENDP



computeDifferences	PROC
				
				PUSH {LR}
				
				
				SUB R2, R1, #1	; number of iterations for the routine
				MOV R3, R0		;Array index
				MOV R9, R2		; the counter for outer loop 4 in this case
				MOV R10, #4		; the counter for inner loop, 4 in this case, but will decrease after every outer loop  
				
lpouter			ADD R3, R3, #4	; this points to M[0][1] at the start of first loop
				;PUSH {R1}		; saving counter of outerloop
				;SUB R9, R1, #1	; no of iteration of inner loop
				MOV R4, R3		; R4 points to M[i][1] where i will be incremented in inner loop j will be incremented by outer loop
lpinner					
				SUB R5, R4, #4   	; R5 points to M[i][0]
				LDR R8, [R5]		; move the value from R5
				MUL R6, R1, R2		
				ADD R6, R5			; R6 points to M[i+1][0]; first iteration (0+20)
				LDR R11, [R6]
				SUB R11, R11, R8
				BVC skipV
				LDR R11, = Constant1	;if overflow occurs The value becomes 0x7FFFFFFF				
skipV				
				STR R11, [R4] 		;storing the value in M[i][1]
				ADD R4, R6, #4		; now R4 points to M[i+1][j]
				
				SUB R10, #1
				CMP R10, #0
				BNE lpinner
				SUB R9, #1			
				MOV R7, R2			; algorithm to decrement the actual counter for inner loop
				SUB R7, R9 
				MOV R10, R2
				SUB R10, R10, R7 	; R10 will be 3 in next iteration and 2 in next
				
				CMP R9, #0
				BNE lpouter
						
				POP {PC}
			
				ENDP



initializeMatrix	PROC
				
				PUSH {LR}
				
				MOV R4, R2 		;Counter for the loop 
				
lp				LDR R5, [R1], #4	; taking element from array				
				STR R5, [R0], #20	; storing it in array at each row in column '0'
				
				SUB R4, #1
				CMP R4, #0
				BNE lp
				
				
				POP {PC}
				
				ENDP

; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
