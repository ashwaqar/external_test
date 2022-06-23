#!/bin/bash

# check if ID exists
app_id_exists=$(curl -s -X GET 'https://api.newrelic.com/v2/applications.json' \
                    -H "Api-Key:${NEW_RELIC_API_KEY}" \
                    -d "filter[name]=${NEW_RELIC_APP_NAME}-${TARGET_ENVIRONMENT}" \
                    | jq -r '.applications[] | has("id")')

if [[ ${app_id_exists} != 'true' ]]; then
    echo "couldn't find new relic app ID. Exit"
    exit 1
fi

APP_ID=$(curl -s -X GET 'https://api.newrelic.com/v2/applications.json' \
            -H "Api-Key:${NEW_RELIC_API_KEY}" \
            -d "filter[name]=${NEW_RELIC_APP_NAME}-${TARGET_ENVIRONMENT}" \
            | jq -r '.applications[0].id');

echo "APP_ID for ${NEW_RELIC_APP_NAME}-${TARGET_ENVIRONMENT} is ${APP_ID}"

current_timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

echo "current timestamp is ${current_timestamp}"

curl -X POST "https://api.newrelic.com/v2/applications/$APP_ID/deployments.json" \
     -H "Api-Key:$NEW_RELIC_API_KEY" \
     -i \
     -H "Content-Type: application/json" \
     -d \
        '{
          "deployment": {
            "revision": "REVISION",
            "changelog": "Deployment through ArgoCD",
            "description": "'"${DEPLOYED_VERSION}"'",
            "user": "'${CF_BUILD_INITIATOR}'",
            "timestamp": "'${current_timestamp}'"
          }
        }'
exit $?