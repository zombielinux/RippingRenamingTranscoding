#!/bin/bash

IFS=$'\n'

#echo "working"
inputfolder='/media/Array/Media/Audio/Rippin_Shit/Test_Output'

for f in $(find $inputfolder -type f -name '*.flac')
do 
	#Get filename without extension
	filename=$(basename $f .flac)
	foldername=$(dirname $f)
	echo "$filename"
	echo "$foldername"
	echo "$foldername/$filename"

	
	#Transcode
	ffmpeg -threads 4 -i $f -c:a alac -n $foldername/$filename.m4a

	#Find filename of cover
	albumcover=$(find $foldername -type f -name 'cover.*')
	echo $albumcover

	#Write album cover to file	
	AtomicParsley $foldername/$filename.m4a --artwork $albumcover --overWrite

	#Delete flac file
	rm $f
done

exit 0
