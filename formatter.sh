#!/bin/bash

FILE_CONTENTS=$(cat)


curl -s -G "http://localhost:8080/xtext-service/format?resource=text.mydsl" --data-urlencode "fullText=$FILE_CONTENTS" -X POST | jq -r '.["formattedText"]'
