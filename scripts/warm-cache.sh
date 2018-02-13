#!/bin/bash


find app/resources/public -type f | cut -d/ -f4- | sed -e 's/^/https:\/\/tinydatacenter\.com\//' | xargs -n1 curl -o /dev/null
