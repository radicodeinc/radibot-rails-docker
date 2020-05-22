# syntax = docker/dockerfile:experimental
FROM ruby:2.6.3
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y curl apt-transport-https wget build-essential nodejs postgresql-client && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV ENTRYKIT_VERSION 0.4.0

RUN curl -LO https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    tar zxvf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    mv entrykit /bin/entrykit && \
    chmod +x /bin/entrykit && \
    entrykit --symlink

