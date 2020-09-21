# syntax = docker/dockerfile:experimental
FROM ruby:2.6.5 AS nodejs
ENV LANG C.UTF-8

WORKDIR /tmp

RUN curl -LO https://nodejs.org/dist/v13.11.0/node-v13.11.0-linux-x64.tar.xz
RUN tar xvf node-v13.11.0-linux-x64.tar.xz
RUN mv node-v13.11.0-linux-x64 node

FROM ruby:2.6.5

COPY --from=nodejs /tmp/node /opt/node
ENV PATH /opt/node/bin:$PATH
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.16.0
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH

RUN apt-get update && apt-get install -y curl apt-transport-https wget build-essential postgresql-client && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV ENTRYKIT_VERSION 0.4.0

RUN curl -LO https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    tar zxvf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    mv entrykit /bin/entrykit && \
    chmod +x /bin/entrykit && \
    entrykit --symlink

