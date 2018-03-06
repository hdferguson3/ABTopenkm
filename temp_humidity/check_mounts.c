#include <stdio.h>
#include <stdlib.h>
#include <mntent.h>
#include <string.h>
#include "check_mounts.h"

int result;

int check_mounts(void)
{
	struct mntent *ent;
	FILE *aFile;
	char *mount_point = "some first mount";
	char remote_mount[] = "\057\057192.168.255.3/ABT Server/Project Management/ChemLabEnvTracking";
	result = 1;
	aFile = setmntent("/proc/mounts", "r");
	if (aFile ==NULL) {
	perror("setmnntent");
	}
	while (NULL != (ent = getmntent(aFile))) {
		mount_point = ent->mnt_fsname;
		//printf("%s\n", mount_point);
		result = strcmp(remote_mount, mount_point);
		if (result == 0)
		{
			printf("STOP, remote mount found\n");
			break;
		}
		else
		{
			//printf("check next mount point\n");
		}
	}
	endmntent(aFile);
}
