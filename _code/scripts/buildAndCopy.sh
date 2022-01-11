#!/bin/bash

python3.9 changeVersion.py

flutter build web
cp -r ../build/web/* ../../

git fetch origin
git add --all
git commit -m "$1"
git push -u origin
