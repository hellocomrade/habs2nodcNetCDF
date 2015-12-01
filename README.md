# habs2nodcNetCDF
A tool for generating NODC-compliant NetCDF file with observation data

Requirements:
1. NetCDF C library 4.X;
2. Python 2.7.X with psycopg2
3. lua 5.X
4. bash

Data processing and massaging is supposed to be a straightforward task. However, There are couple challenges:

1. Both data and metadata need to be standardized;
2. Usually data and metadata are managed and maintained by different team member;
3. Data analyst is usually familiar with script language, such as python and feel comfortable to work with database through scripting;
4. Data couriers, on the other hand, may or may not have programming experience. However, they are OK to work with certain data format, such as XML;

These challenges inspire us to create a package that can be used by memebers in the team collaboratively:

1. Data people are responsible to script the routine to pull data from whatever source using python;
2. Metadata people are responsible to edit the metadata record for each observation platform using lua table;
3. A C script was written to make sure combining the outcomes from step 1 and 2 together into a valid file in NetCDF format;
4. Bash script is on top to automate the whole process and the final product will be a compressed dataset for a platform and its md5sum;

Installation:

Simply copy files, put them in a folder, then

#make

This should compile C script for you. Make sure you have libnetcdf and liblua available on the machine.

The last step will be store the folder's absolute name on the first line of commom.lua


Preparation:

In order to have a valid NODC submittal, browse all global metadata attributes inside common.lua.

Usage:

In order to link a platform with this tool. Two files are necessary, a lua file is needed in platform-config/platform_name folder to specifiy the specific
metadata attributes. This also includes the location for C script to retrieve the data file for a measurement.

Then a python script file is needed in platform/platform_name folder for retrieving observation data from a data source. For our case here, the data store is 
a PostgreSQL database.
 
