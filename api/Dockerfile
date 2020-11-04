FROM ruby:2.7.2-alpine3.12 as build

RUN apk add --update --no-cache build-base \
                                linux-headers \
                                postgresql-dev \
                                git \
                                tzdata

WORKDIR /app

ENV RAILS_ENV='production'
ENV RACK_ENV='production'
ENV RAILS_LOG_TO_STDOUT=1

COPY Gemfile* /app/
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY . .
COPY ./config/database.yml.docker ./config/database.yml
RUN mkdir -p puma/sockets puma/logs puma/pids

EXPOSE 3000
