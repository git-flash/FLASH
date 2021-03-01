#!/bin/bash
set -e

sleep 1

rm -f /myapp/tmp/pids/server.pid
rails db:migrate
rails db:seed
rails ts:routes

exec "$@"
