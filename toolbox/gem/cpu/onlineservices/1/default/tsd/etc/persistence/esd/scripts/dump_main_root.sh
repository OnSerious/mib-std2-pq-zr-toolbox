#!/bin/ksh
export TOPIC=j5_root
export MIBPATH=/
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump root of J5 SD card/USB drive"
echo

# Locate Toolbox drive
. /tsd/etc/persistence/esd/scripts/util_checksd.sh

# Include info utility
. /tsd/etc/persistence/esd/scripts/util_info.sh

#Make dump folder
DUMPFOLDER=$VOLUME/dump/$VERSION/$SERIAL/$SDPATH

#Make dump folder if needed
if [ ! -d "$DUMPFOLDER" ]; then
	echo "Making $DUMPFOLDER..."
	mkdir -p $DUMPFOLDER
fi

if [ -f /net/J5 ]; then
	SRC=/net/J5
fi

echo "Listing files..."
ls -al ${SRC}/ >${DUMPFOLDER}/root.txt
ls -al ${SRC}/dev/ >>${DUMPFOLDER}/root.txt
if [ -f "$SRC/net" ]; then
	ls -al ${SRC}/net >>${DUMPFOLDER}/root.txt
fi
for d in ${SRC}/*; do
	if [ "$d" != "$SRC/cpu" ] && [ "$d" != "$SRC/dev" ] && [ "$d" != "$SRC/net" ]; then
		echo "Dumping $d"
		cp -r ${d} ${DUMPFOLDER}
	fi
done
sync
echo
echo "Done. Saved at $DUMPFOLDER"
exit 0