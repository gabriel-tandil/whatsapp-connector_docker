#!/bin/bash

for var in "$@"
do
    /opt/cuentasWhatsapp/actualizar.sh $var
    sleep 55s
done
        
