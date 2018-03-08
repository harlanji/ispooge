#!/bin/bash

source scripts/env.sh

docker logs --since=1m --follow $NAME
