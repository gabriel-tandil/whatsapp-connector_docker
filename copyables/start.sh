#!/bin/bash
if test -e "config.json"
then
    echo "Starting whatsapp-connector - ^C to exit." |& tee -a log.txt
    until ( set -o pipefail;  node whatsapp-connector.js |& tee -a log.txt;  ) do
        if test $? -eq 130
	then
	    break
	fi
        echo "whatsapp-connector exited" |& tee -a log.txt
        sleep $[ ( $RANDOM % 20 ) + 20 ]
        echo "Respawning.." |& tee -a log.txt
    done
else
    echo "config.json not found." |& tee -a log.txt
fi
bash

   
