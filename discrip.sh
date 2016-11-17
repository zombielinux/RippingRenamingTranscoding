#!/bin/bash

WORKINGDIR="/media/Array/Media/Audio/Rippin_Shit"
RIPPEDDIR="/Test_Input"

cd $WORKINGDIR$RIPPEDDIR

#Actually do the ripping
abcde -j 4 -o flac -p -a cddb,replaygain,tag,getalbumart,clean,cue -D 2>log

#Tell you System is ready for next disc
curl http://textbelt.com/text -d number=8139921311 -d "message=I am server, insert disc"

#Insert data into SQL table
python $WORKINGDIR/disclist.py

#Eject the disk
eject

exit
