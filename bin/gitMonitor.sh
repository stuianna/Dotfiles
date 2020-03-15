#!/bin/bash

# Check the correct number of arguments
if [ $# != 2 ]
then
	echo "Correct useage is ./gitMonitor.sh path/to/directory filename [update]"
	exit 0
fi

# Update the repository
if [ "$2" == "update" ]
then
	cd $1
	git stash
	git fetch && git pull
	git stash pop
	exit 0
fi

# Start up the monitor
cd $1
inotifywait -m -e modify --format="git fetch && git pull && git add $2 && git commit -m 'auto commit' && git push origin master" $2 | bash
