#!/bin/bash
#
#set -x

IMAGE=flutter-android-sdk
project_name=$1
project_root=$PWD/../..
create=''

if [[ -z $project_name ]]; then
	echo "give the name of the project as parameter"
	exit 1
fi

if [[ ! -d $project_root/$project_name ]]; then
	mkdir $project_root/$project_name
else
	if [[ $(find $project_root/$project_name -name 'pubspec.yaml' | wc -l) == 1 ]]; then
		create=no
	else
		create=yes
	fi		
fi

docker build -t $IMAGE -f Dockerfile .

cp $project_root/$project_name ./
if [[ $create == yes ]]; then
	docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/ $IMAGE flutter create $project_name
fi

echo "testing the app..."
docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/$project_name $IMAGE flutter test
