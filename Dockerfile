FROM ruby:3.2.3

ENV BUNDLER_VERSION=2.2.8

RUN gem install bundler:$BUNDLER_VERSION
RUN apt-get update -y && apt-get install -y cmake

# INSTALL NODEJS
RUN apt-get remove -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

# INSTALL YARN
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY package.json yarn.lock ./
COPY . ./

ARG RAILS_ENV=production
ARG DATABASE_URL

RUN mv /app/config/database.yml.docker /app/config/database.yml
RUN bundle exec rake assets:precompile

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "bundle exec rake db:migrate && bundle exec rails s -b 0.0.0.0" ]
