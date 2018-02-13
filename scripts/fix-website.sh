#!/bin/bash

scripts/build-static.sh && (scripts/stop-static.sh ; scripts/start-static.sh)
