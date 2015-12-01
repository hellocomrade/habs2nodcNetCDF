#!/bin/bash
if [ $# -lt 1 ] ; then
    echo 'need a start date [alternative date on file name]'
    exit -1
fi
for f in ./platform/*
do
    if [ -d $f -a -x $f/$(basename $f).run ]; then
	base=$(basename $f)
	echo $f/${base}.run $1        
        $($f/${base}.run $1)
	if [ $? -eq 0 ];then
	    echo "obs2nc on platform-config/"${base}
	    ./obs2nc platform-config/${base}
	    if [ $? -eq 0 ]; then
		for f in ./*.nc; do
    		    /usr/bin/md5sum $f > ${f}.md5
		done
		pwd=$(pwd)
		filebase=glos_${base}_$(date +%Y_%m_%d)
		if [ -n "$2" ]; then
		    filebase=glos_${base}_$2
		fi
		tar -zcf $(pwd)/output/${filebase}.tar.gz ${base}*.nc*
		/usr/bin/md5sum $(pwd)/output/${filebase}.tar.gz > $(pwd)/output/${filebase}.tar.gz.md5
		rm ./${base}*.nc*
	    else
		echo "Failed to obs2nc on "${base}
	    fi
	fi 
    fi
done
