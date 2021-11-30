#!/bin/bash

MULESOFT_CONNECTED_APP_TOKEN=`curl "https://anypoint.mulesoft.com/accounts/api/v2/oauth2/token" -H 'Content-Type: application/json' -d '{"client_id" : "'"${MULESOFT_CONNECTED_APP_CLIENT_ID}"'","client_secret": "'"${MULESOFT_CONNECTED_APP_CLIENT_SECRET}"'","grant_type" : "client_credentials"}' | jq -r '.access_token'`

cf_export MULESOFT_CONNECTED_APP_TOKEN=${MULESOFT_CONNECTED_APP_TOKEN}