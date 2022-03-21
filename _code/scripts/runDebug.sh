#!/bin/bash

hostName='0.0.0.0'
hostPort='5000'

flutter pub get
bash killProcessPort.sh $hostPort
flutter run -d web-server --web-port $hostPort --web-hostname $hostName