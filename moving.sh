#!/bin/bash

#echo "working"
inputfolder='/media/Array/Media/Audio/Rippin_Shit/Test_Input'
outputfolder='/media/Array/Media/Audio/Rippin_Shit/Test_Output'

for f in $(find $inputfolder -name '*.flac')
do 
	#Get necessary track information
	artist=$(metaflac --list --block-number=2 $f | grep ARTIST= | cut -d=   -f2)
	album=$(metaflac --list --block-number=2 $f | grep ALBUM= | cut -d=   -f2)
	title=$(metaflac --list --block-number=2 $f | grep TITLE= | cut -d=   -f2)
	date=$(metaflac --list --block-number=2 $f | grep DATE= | cut -d=   -f2)
	tracknumber=$(metaflac --list --block-number=2 $f | grep TRACKNUMBER= | cut -d=   -f2)

	foldername=$(dirname $f)
	
	#Get renamed important shit
	albumfolder=$(echo $album" ("$date")")
	uncleanfilename=$(echo $tracknumber"-"$title".flac")
	filename=$(echo "$uncleanfilename" | sed -r 's/[/]+/-/g')
		

	#Make the directories and copy the files
	mkdir -p $outputfolder/"$artist"
	mkdir -p $outputfolder/"$artist"/"$albumfolder"
#	echo "Moving "$f" to "$filename
	rsync -u $f $outputfolder/"$artist"/"$albumfolder"/"$filename"
	rsync -u $foldername/cover* $outputfolder/"$artist"/"$albumfolder"/
done

exit 0
