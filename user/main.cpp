#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "driver.hpp"

uint64_t get_tick_count64()
{
	struct timespec ts;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	return (ts.tv_sec * 1000 + ts.tv_nsec / (1000 * 1000));
}

pid_t get_name_pid(char *name)
{
	FILE *fp;
	pid_t pid;
	char cmd[0x100] = "pidof ";

	strcat(cmd, name);
	fp = popen(cmd, "r");
	fscanf(fp, "%d", &pid);
	pclose(fp);
	return pid;
}

int main(int argc, char const *argv[])
{

	uintptr_t base = 0;
	uint64_t result = 0;
	char module_name[0x100] = "libunity.so";
	pid_t pid = get_name_pid((char *)"com.tencent.tmgp.sgame");
	printf("pid = %d\n", pid);

	driver->initialize(pid);

	base = driver->get_module_base(module_name);
	printf("base = %lx\n", base);

	{
		size_t number = 1;
		uint64_t now = get_tick_count64();
		for (size_t i = 0; i < number; i++)
		{
			result = driver->read<uint64_t>(base);
		}
		printf("Read %ld times cost = %lfs\n", number,
			   (double)(get_tick_count64() - now) / 1000);
	}
	printf("result = %lx\n", result);

	return 0;
}
