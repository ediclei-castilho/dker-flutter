#!/bin/bash
#
#set -x

IMAGE=flutter-android-sdk
project_name=$1
create=''

if [[ -z $project_name ]]; then
	echo "give the name of the project as parameter"
	exit 1
fi

if [[ ! -d $PWD/$project_name ]]; then
	mkdir $PWD/$project_name
else
	if [[ $(find $project_name -name 'pubspec.yaml' | wc -l) == 1 ]]; then
		create=no
	else
		create=yes
	fi		
fi

docker build -t $IMAGE -f Dockerfile .

if [[ $create == yes ]]; then
	docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/ $IMAGE flutter create $project_name
fi


echo "testing the app..."
docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/$project_name $IMAGE flutter test

echo "creating an alias for you"
echo "next time you can simply run 'flutter <commands>'"
echo "example: flutter test"

#alias flutter="docker run --rm -it -v $PWD/$project_name:/root/$project_name -w /root/$project_name flutter-ubuntu flutter"
#flutter test
