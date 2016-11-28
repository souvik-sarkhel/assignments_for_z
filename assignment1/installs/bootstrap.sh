#!/bin/bash
#Command to start mongod server
service mongod start
#command to start Tomcat
/usr/share/tomcat/bin/catalina.sh start

#Condition to keep to container running if -d is passed as argument
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi
#Condtion to login into container while in interactive mode
if [[ $1 == "-bash" ]]; then
  /bin/bash
fi