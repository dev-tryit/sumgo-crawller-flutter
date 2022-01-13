#!/bin/bash

echo "----python3.9 changeVersion.py"
python3.9 changeVersion.py

echo "----flutter build web"
buildInfo=$(flutter build web)
if [[ $buildInfo =~ *"Fail"* ]]; then
	exit 0
else
	echo "----[success]flutter build web"
fi

echo "cp -r ../build/web/* ../../"
cp -r ../build/web/* ../../

echo "----git fetch origin"
git fetch origin

echo "----git add --all"
git add --all

echo "----git commit -m $1"
git commit -m "$1"

echo "----git push -u origin"
git push origin
