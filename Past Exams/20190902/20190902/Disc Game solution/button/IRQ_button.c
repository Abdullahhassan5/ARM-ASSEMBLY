#include "button.h"
#include "lpc17xx.h"
extern char* grid;

void EINT0_IRQHandler (void)	  
{
	all_LED_off();
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	
	if (checkDiagonal(1, grid))
	{
		LED_On(5);
	}
	else if (checkRow(1, grid))
	{
		LED_On(6);
	}
	else 
		LED_On(7);
	
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	if (checkDiagonal(2, grid))
	{
		LED_On(1);
	}
	else if (checkRow(2, grid))
	{
		LED_On(2);
	}
	else 
		LED_On(3);
	
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}


