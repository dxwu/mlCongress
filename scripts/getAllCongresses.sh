#!/bin/bash

mkdir -p Congress
cd Congress

NUM=103
while [ $NUM -lt 114 ]; do
	mkdir -p $NUM 
	let NUM=$NUM+1
done

rsync -avz govtrack.us::govtrackdata/congress/103/bills 103/
rsync -avz govtrack.us::govtrackdata/congress/104/bills 104/
rsync -avz govtrack.us::govtrackdata/congress/105/bills 105/
rsync -avz govtrack.us::govtrackdata/congress/106/bills 106/
rsync -avz govtrack.us::govtrackdata/congress/107/bills 107/
rsync -avz govtrack.us::govtrackdata/congress/108/bills 108/
rsync -avz govtrack.us::govtrackdata/congress/109/bills 109/
rsync -avz govtrack.us::govtrackdata/congress/110/bills 110/
rsync -avz govtrack.us::govtrackdata/congress/111/bills 111/
rsync -avz govtrack.us::govtrackdata/congress/112/bills 112/
rsync -avz govtrack.us::govtrackdata/congress/113/bills 113/
