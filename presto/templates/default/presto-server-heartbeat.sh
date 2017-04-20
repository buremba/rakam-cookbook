#!/bin/sh

SENTRY_KEY=
SENTRY_SECRET=
SENTRY_PROJECTID=62493
SENTRY_HOST=sentry.io

while true
do 
if ! pgrep presto-server; then
    /home/webapp/presto/bin/launcher start
fi
 sleep 5
done
