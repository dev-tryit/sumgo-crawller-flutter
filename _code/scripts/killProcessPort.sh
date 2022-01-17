#!/bin/bash

info=$(lsof -t -i:$1)
kill -9 $info