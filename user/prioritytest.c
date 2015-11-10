// Test preemption by forking off a child process that just spins forever.
// Let it run for a couple time slices, then kill it.

#include <inc/lib.h>

void
umain(int argc, char **argv)
{
	envid_t env;
	sys_acquire_priority(1);
	cprintf("I am the super parent.  Forking the child...\n");
	if ((env = fork()) == 0) {
		cprintf("I am the child.\n");


	} else {
		cprintf("I am the parent.\n");
		sys_yield();	
		cprintf("I should be print ahead of child\n");
		sys_yield();	
		cprintf("I should be print ahead of child\n");
		sys_yield();	
		cprintf("Now I'm leaving\n");






		//cprintf("I am the parent.  Killing the child...\n");
		//sys_env_destroy(env);

	}

}

