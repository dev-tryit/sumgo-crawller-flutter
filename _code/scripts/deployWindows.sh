#!/bin/bash

p_path='C:\Users\1\Project\sumgo_crawller_flutter\_code'
echo "$p_path"
cd $p_path

echo "rm -r ./build/windows/runner/Release/*"
rm -rf ./build/windows/runner/Release/*

echo "flutter build windows"
flutter build windows

echo "rm -r ../deploy/SumgoManager.zip"
rm -r ../deploy/SumgoManager.zip


cd "./build/windows/runner/Release"
echo "zip -r $p_path/../deploy/SumgoManager.zip ./*"
zip -r $p_path/../deploy/SumgoManager.zip ./*