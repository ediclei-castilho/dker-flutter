#!/bin/bash
#

project_name=$1
if [[ -z $project_name ]]; then
	echo "give the name of the project as parameter"
	exit 1
fi
if [[ ! -d $PWD/$project_name ]]; then
	mkdir $PWD/$project_name
fi

docker build -t flutter-ubuntu -f Dockerfile-ubuntu .

docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/ flutter-ubuntu flutter create $project_name
docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/$project_name flutter-ubuntu flutter test
