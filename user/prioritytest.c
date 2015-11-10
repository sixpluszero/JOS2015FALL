
#include <inc/lib.h>

void
umain(int argc, char **argv)
{
	envid_t env;
	int i;
	//sys_acquire_priority(1);
	cprintf("I am the super parent.  Forking the child...\n");
	if ((env = pfork()) == 0) {
		cprintf("I am the child...\n");
	} else {
		cprintf("I am the parent.\n");
		for (i = 1; i <= 5; i++){
			sys_yield();	
			cprintf("I should be print ahead of child\n");
		}
		cprintf("Now I'm leaving\n");
	}

}

