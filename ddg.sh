#!/bin/bash
(pv -n $1 | dd of=$2 bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
