#!/bin/sh

SENTRY_KEY=
SENTRY_SECRET=
SENTRY_PROJECTID=62493
SENTRY_HOST=sentry.io

capture_error()
{

MESSAGE=$1
EVENT_ID=`openssl rand -hex 32`
EVENT_TIMESTAMP=`date +"%Y-%m-%dT%H:%M:%S"`
SENTRY_TIMESTAMP=`date +%s`

curl --data "{
    \"event_id\": \"$EVENT_ID\",
    \"culprit\": \"$0\",
    \"timestamp\": \"$EVENT_TIMESTAMP\",
    \"message\": \"$MESSAGE\",
    \"tags\": {
        \"shell\": \"$SHELL\",
        \"server_name\": \"`hostname`\",
        \"path\": \"`pwd`\"
    },
    \"exception\": [{
        \"type\": \"ScriptError\",
        \"value\": \"$MESSAGE\",
        \"module\": \"__builtins__\"
    }],
    \"extra\": {
        \"sys.argv\": \"$SCRIPT_ARGUMENTS\"
    }
}" -H "Content-Type: application/json" -H "X-Sentry-Auth: Sentry sentry_version=5, sentry_timestamp=$SENTRY_TIMESTAMP,
    sentry_key=$SENTRY_KEY, sentry_client=raven-bash/0.1,
    sentry_secret=$SENTRY_SECRET" http://$SENTRY_KEY:$SENTRY_SECRET@$SENTRY_HOST/api/$SENTRY_PROJECTID/store/

}

while true
do 
if ! pgrep presto-server; then
    capture_error "Unable to execute the command" && /home/webapp/presto/bin/launcher start
fi
 sleep 5
done