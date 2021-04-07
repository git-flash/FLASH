#!/bin/bash
set -e

sleep 1

rm -f /myapp/tmp/pids/server.pid
if [ "$FLASH_ENV" == "test" ]
then
  echo "testing"
else
  rails db:migrate
  rails db:seed
fi

rails ts:routes

exec "$@"
