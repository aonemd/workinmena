#!/bin/sh

docker-compose \
  -f workinmena-deploy/docker-compose.yml \
  --project-directory . \
  down
