#!/bin/bash

p_path='C:/Users/imkim/StudioProjects/sumgo_crawller_flutter/_code'
echo "$p_path"
cd $p_path

echo "rm -r ../deploy/SumgoManager.zip"
rm -r ../deploy/SumgoManager.zip

echo "zip -r ../deploy/SumgoManager.zip ./build/windows/runner/Release/*"
zip -r ../deploy/SumgoManager.zip ./build/windows/runner/Release/*