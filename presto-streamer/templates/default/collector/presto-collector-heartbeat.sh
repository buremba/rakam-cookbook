#!/bin/sh

while true
do 
if ! pgrep rakam-collector; then
    /home/webapp/presto-streamer/bin/launcher start
fi
 sleep 5
done