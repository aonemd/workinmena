FROM ruby:2.6.2-alpine3.9 as build

RUN apk add --update --no-cache build-base \
                                linux-headers \
                                postgresql-dev \
                                git \
                                tzdata

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY . /app
COPY config/database.yml.docker /app/config/database.yml

EXPOSE 3000
