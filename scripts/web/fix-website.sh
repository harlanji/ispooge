#!/bin/bash

scripts/web/build-static.sh && (scripts/web/stop-static.sh ; scripts/web/start-static.sh)
