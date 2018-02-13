#!/bin/bash

docker run -d --restart always  --name website-v2-static -p 23080:9090 website-v2-static
