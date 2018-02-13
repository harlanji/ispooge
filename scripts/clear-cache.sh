#!/bin/bash

CF_KEY=aaaaaaaaaaaaaaaaaa
CF_EMAIL=aaaaaaa@gmail.com
CF_ZONE=bbbbbbbb

curl -H"X-Auth-Email: $CF_EMAIL" -H"X-Auth-Key: $CF_KEY" \
  -X DELETE https://api.cloudflare.com/client/v4/zones/$CF_ZONE/purge_cache \
  -H"Content-Type: application/json" \
  -d '{"purge_everything": true}'
