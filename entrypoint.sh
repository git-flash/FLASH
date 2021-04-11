#!/bin/bash
set -e

sleep 1

rm -f /myapp/tmp/pids/server.pid
if [ "$FLASH_ENV" == "test" ]
then
  rails db:migrate RAILS_ENV=test
  rails db:seed RAILS_ENV=test
  echo "testing"
else
  rails db:migrate
  rails db:seed
fi

rails ts:routes

exec "$@"
