FROM ruby:alpine

RUN apk update
RUN apk add git alpine-sdk

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec" , "rackup", "-o", "0.0.0.0", "-p", "8080"]