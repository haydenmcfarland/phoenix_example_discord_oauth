#!/bin/sh

set -e

mix deps.get --force

until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  psql -h db -U "postgres"
  >&2 echo "Waiting for postgres service..."
  sleep 1
done

printf "Installing JS dependencies..."
cd assets && npm install && npm rebuild node-sass
cd ..

printf "Continuing with database setup..."

mix ecto.create
mix ecto.migrate

printf "Launching web server..."

mix phx.server
