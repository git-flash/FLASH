#!/bin/bash

set -e

docker container prune -f
docker-compose -f test-docker-compose.yml build
docker-compose -f test-docker-compose.yml up
