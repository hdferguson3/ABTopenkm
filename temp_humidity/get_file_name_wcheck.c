#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <unistd.h>
#include "get_file_name_wcheck.h"
#include "check_mounts.h"

char filepath[80];

int get_file_name(void)

{
	time_t rawtime;
	struct tm *info;
	char buffer[80];
	FILE *fp;

	time( &rawtime );

	info = localtime ( &rawtime );

	strftime(buffer,80,"%B_%Y", info); //gets date

	check_mounts();
	if (result == 0)
	{
		sprintf(filepath,"/mnt/temp_humidity_data/%s_environmental_data.csv", buffer );
	}
	else
	{
		system("/home/pi/temp_humidity/mount_network.sh");
		sleep (15);
		check_mounts();
		if (result == 0)
		{
			sprintf(filepath,"/mnt/temp_humidity_data/%s_environmental_data.csv", buffer );
		}
		else
		{
			sprintf(filepath,"/home/pi/temp_humidity/data/%s_environmental_data.csv", buffer );
		}
	}

	fp = fopen(filepath, "a"); //"a" is for append, create if does not exist
	if (fp){
		printf("%s\n", filepath);
		fclose(fp);
	}else{
		printf("File crash\n");
		}

}
