#!/bin/sh

bin/rails db:setup
bin/rails db:views:refresh

bin/bundle exec puma
