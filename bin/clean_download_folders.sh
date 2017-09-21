#!/bin/bash

# Arguments
dir_to_clean=$1
archive_dir_prefix=archive_
archive_dir_date=$(date "+%y-%m-%d")


# Check if source directory exists
if [[ -z ${dir_to_clean} ]]; then
	echo "ERROR: You must give a path as argument"
	exit 1
elif [[ ! -d ${dir_to_clean} ]]; then
	echo "ERROR: Source directory does not exists: ${dir_to_clean}"
	exit 1
fi

# Create destination path
archive_dir_name=${archive_dir_prefix}${archive_dir_date}

# Create destination directory
if [ ! -d "${dir_to_clean}/${archive_dir_name}" ]; then
	mkdir "${dir_to_clean}/${archive_dir_name}"
fi

# Move all files into this directory
#echo "find ${dir_to_clean} ! -name ${archive_dir_prefix}* -depth 1 -exec echo {} \; | sort"
while read -r file; do
	echo "INFO: Moving ${file}"
	mv "${file}" "${dir_to_clean}/${archive_dir_name}"
done < <(find ${dir_to_clean} ! -name ${archive_dir_prefix}* -depth 1 -exec echo {} \; | sort)



