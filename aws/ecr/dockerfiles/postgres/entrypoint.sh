#!/bin/sh

crond -1 2 -f &

exec docker-entrypoint.sh postgres
