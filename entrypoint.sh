#!/bin/bash
set -e

rm -f /myapp/tmp/pids/server.pid
rails db:migrate

exec "rails" "server" "$@"
