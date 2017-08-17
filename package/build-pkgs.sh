#!/bin/bash


DOCKER_FILES="$1"

for f in $DOCKER_FILES; do
	DEST_BUILD_DIR="$(echo $f | sed 's/\.docker$/-build/g')"
	
	#Clean start copy fresh sources
	if [ -d $DEST_BUILD_DIR ]; then rm -rf $DEST_BUILD_DIR; fi
	
	mkdir -p $DEST_BUILD_DIR
	cp -r source/* $DEST_BUILD_DIR/

	docker build -t "$(basename $(pwd))-$(echo $f | sed 's/\.docker$//g')" -f $f .

	echo "docker run --rm -i -t -v "$(pwd)/$DEST_BUILD_DIR":/build $(basename $(pwd))-$(echo $f | sed 's/\.docker$//g') "/bin/bash""

done
	


