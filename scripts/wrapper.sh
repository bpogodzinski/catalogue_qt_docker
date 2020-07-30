#!/bin/bash

export LD_LIBRARY_PATH=/home/imas/imas/core/IMAS/3.28.1-4.8.1/lib
export CLASSPATH=/home/imas/imas/core/IMAS/3.28.1-4.8.1/jar/imas.jar:/usr/share/java/saxon9he.jar
export IMAS_PREFIX=/home/imas/imas/core/IMAS/3.28.1-4.8.1
export IMAS_VERSION=3.28.1
export IMAS_HOME=/home/imas/imas
export ids_path=/home/imas/imas/core/IMAS/3.28.1-4.8.1/models/mdsplus
export UAL_VERSION=4.8.1

loop=1
tries=10

while [ $loop == 1 ]; do

  curl -s http://localhost:8080 > /dev/null 2>&1
  retVal=$?

  if [ $retVal -ne 0 ]; then
    sleep 10
    tries=$((tries-1))
    if [ $tries == 0 ]; then
      echo "Failed to connect to Catalog QT server"
      exit 1
    fi
  else
    loop=0
  fi


done

java -jar target/catalogAPI.jar -startUpdateProcess --url http://127.0.0.1:8080 --slice-limit 100