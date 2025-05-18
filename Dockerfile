# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim

WORKDIR /app

ENV BUNDLE_PATH="/usr/local/bundle" \
    RAILS_ENV=development \
    PATH="/app/bin:$PATH"

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    curl && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN yarn install --check-files || true
