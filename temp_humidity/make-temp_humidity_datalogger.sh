#!/bin/bash
# script to compile temp_humidity_datalogger

# Compile object files

gcc -c check_mounts.c
gcc -c get_file_name_wcheck.c
gcc -c check_time.c
gcc -c get_date_time.c
gcc -c temp_humidity_datalogger.c

# Compile output file and add wiringPi link

gcc -o temp_humidity_datalogger check_mounts.o get_file_name_wcheck.o check_time.o get_date_time.o temp_humidity_datalogger.o -lwiringPi
