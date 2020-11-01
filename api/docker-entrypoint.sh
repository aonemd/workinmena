#!/bin/sh

bin/rails db:setup

bin/bundle exec puma
