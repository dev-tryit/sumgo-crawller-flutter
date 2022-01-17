#!/bin/bash

hostName='158.247.217.214'
hostPort='5000'

bash killProcessPort.sh $hostPort
flutter run -d web-server --web-port $hostPort --web-hostname $hostName