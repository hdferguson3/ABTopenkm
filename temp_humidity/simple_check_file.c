# include <stdio.h>
# include <dirent.h>
# include <errno.h>

void main (void)
{
	DIR* dir = opendir("/mnt/temp_humidity_data");
	if (dir)
	{
		printf("directory exists\n");
		close(dir);
	}
	else if (ENOENT == errno)
	{
		printf("directory does not exist\n");
	}
	else
	{
		printf("open() failed for some other reason\n");
	}
}
