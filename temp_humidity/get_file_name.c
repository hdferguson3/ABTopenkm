#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <unistd.h>
#include "get_file_name.h"

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
	sprintf(filepath,"/mnt/temp_humidity_data/%s_environmental_data.csv", buffer ); //appends date to file path

	fp = fopen(filepath, "a"); //"a" is for append, create if does not exist
	if (fp){
		printf("%s\n", filepath);
		fclose(fp);
	}else{
		sprintf(filepath,"/home/pi/temp_humidity/data/%s_environmental_data.csv", buffer );
		fp = fopen(filepath, "a");
		if (fp){
			//chmod(filepath, S_IRWXU|S_IRWXG|S_IRWXO);
			printf("%s\n", filepath);
			fclose(fp);
			system("/home/pi/temp_humidity/mount_network.sh");
		}else{
			printf("File crash\n");
		}
	}
}
