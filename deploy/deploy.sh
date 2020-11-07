#!/bin/sh

find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;

docker-compose \
  -f workinmena-deploy/docker-compose.yml \
  --project-directory . \
  up --build
