
#include <inc/lib.h>

void
umain(int argc, char **argv)
{
	envid_t env;
	int i;
	//sys_acquire_priority(1);
	cprintf("I am the super parent.  Forking the child...\n");
	if ((env = pfork()) == 0) {
		for (i = 1; i <= 10; i++){
			cprintf("I am the child...\n");
			sys_yield();
		}
	} else {
		cprintf("I am the parent.\n");
		for (i = 1; i <= 20; i++){
			sys_yield();
			for (int j = 0; j <= 100000; j++);	
			cprintf("I should be print ahead of child\n");
		}
		cprintf("Now I'm leaving\n");
	}

}

