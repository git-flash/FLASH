#!/bin/bash

set -e

docker container prune -f
docker-compose build
docker-compose up
