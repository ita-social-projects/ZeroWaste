FROM ruby:3.3.5

ENV BUNDLER_VERSION=2.2.8

RUN gem install bundler:$BUNDLER_VERSION
RUN apt-get update -y && apt-get install -y cmake

# INSTALL NODEJS
RUN apt-get remove -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY . ./

ARG RAILS_ENV=production
ARG DATABASE_URL

RUN mv /app/config/database.yml.docker /app/config/database.yml
RUN bundle exec rake assets:precompile

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "bundle exec rake db:migrate && bundle exec rails s -b 0.0.0.0" ]
