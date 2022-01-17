#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Brown/Orange='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
LightGray='\033[0;37m'
DarkGray='\033[1;30m'
LightRed='\033[1;31m'
LightGreen='\033[1;32m'
LightGreen='\033[1;32m'
Yellow='\033[1;33m'
LightBlue='\033[1;34m'
LightPurple='\033[1;35m'
LightCyan='\033[1;36m'
LightWhite='\033[1;37m'

echo "${RED}"
echo "----python3.9 changeVersion.py"
python3.9 changeVersion.py
echo "${NC}"

echo "----flutter build web"
{ buildInfo="$(flutter build web --verbose)"; } 2>/dev/null
if [[ !($buildInfo =~ "exiting with code 0") ]]; then
	exit 1
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
