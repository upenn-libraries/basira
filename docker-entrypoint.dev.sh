#!/bin/sh

set -e

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

RAILS_ENV=development bundle exec rake db:migrate:with_data || RAILS_ENV=development bundle exec rake db:setup
RAILS_ENV=test bundle exec rails db:prepare

exec bundle exec "$@"
