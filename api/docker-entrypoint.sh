#!/bin/sh

rm -f tmp/pids/server.pid

bin/rails db:setup

bin/rails s -p 3000 -b '0.0.0.0'
