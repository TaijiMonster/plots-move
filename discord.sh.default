#!/bin/bash
message="$@"
## format to parse to curl
## echo Sending message: $message
msg_content=\"$message\"

## discord webhook
url='https://discord.com/api/webhooks/YOUR-DISCORD-WEBHOOK'
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url

