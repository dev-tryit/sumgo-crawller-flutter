#!/bin/bash

echo "----python3.9 changeVersion.py"
python3.9 changeVersion.py

echo "----flutter build web"
buildInfo = $(flutter build web)
if [[ $string =~ "Fail" ]]; then
	echo "true"
else
	echo "false"
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
