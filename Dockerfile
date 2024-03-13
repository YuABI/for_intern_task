FROM node:20.11 as node
FROM ruby:3.2.3

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV RAILS_ENV development
ENV NODE_ENV development
ENV YARN_VERSION 1.22.19

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev \
    libxslt-dev libxml2-dev redis-server vim imagemagick libmagick++-dev

COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

RUN gem install bundler -v 2.5.6
# Apple シリコン対応
RUN bundle config set force_ruby_platform true

RUN mkdir -p /var/www/my_app
WORKDIR /var/www/my_app

CMD rm -f tmp/pids/server.pid && bin/dev
