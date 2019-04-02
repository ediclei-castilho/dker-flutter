#!/bin/bash
#
#

username=
apiKey=
baseUrl="https://api.kobiton.com/v1"

appPath=
destAppName=

keyBase64=$(echo "${username}:${apiKey}" | base64)
echo $keyBase64

curl -H "Content-Type: application/json" \
        -H "Authorization: Basic ${keyBase64}" \
        -X POST \
        -d '{"filename":"app.apk","appPath":"app.apk"}' \
        ${baseUrl}
