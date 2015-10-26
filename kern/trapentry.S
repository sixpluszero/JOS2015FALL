/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>

#include <kern/picirq.h>


###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */
 
TRAPHANDLER_NOEC(TRAP0,0)
TRAPHANDLER_NOEC(TRAP1,1)
TRAPHANDLER_NOEC(TRAP3,3)
TRAPHANDLER_NOEC(TRAP4,4)
TRAPHANDLER_NOEC(TRAP5,5)
TRAPHANDLER_NOEC(TRAP6,6)
TRAPHANDLER_NOEC(TRAP7,7)
TRAPHANDLER(TRAP8,8)
TRAPHANDLER_NOEC(TRAP9,9)
TRAPHANDLER(TRAP10,10)
TRAPHANDLER(TRAP11,11)
TRAPHANDLER(TRAP12,12)
TRAPHANDLER(TRAP13,13)
TRAPHANDLER(TRAP14,14)
TRAPHANDLER_NOEC(TRAP16,16)
TRAPHANDLER_NOEC(TRAP48,48)



/*
 * Lab 3: Your code here for _alltraps
 */
	.globl _alltraps;
_alltraps:
	push %ds
	push %es
	pushal
	push $GD_KD
	pop %ds
	push $GD_KD
	pop %es
	push %esp
	call trap

.data
	.globl TP0TEST
TP0TEST:
	.space 0x400

