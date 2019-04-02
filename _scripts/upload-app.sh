#!/bin/bash
#
#

username=$KOBITON_USERNAME
apiKey=$KOBITON_API_KEY
baseUrl=$KOBITON_API_URL

appFileName=app.apk
appPath=$DELIVERED_APP_PATH

keyBase64=$(echo "${username}:${apiKey}" | base64)
echo $keyBase64

curl -H "Content-Type: application/json" \
        -H "Authorization: Basic ${keyBase64}" \
        -X POST \
        -d '{"filename":"${appFileName}","appPath":"${appPath}"}' \
        ${baseUrl}
