FROM ruby:2.7.2 as build

RUN apt-get update && apt-get -y upgrade
RUN gem install bundler

RUN mkdir -p /usr/src/api
WORKDIR /usr/src/api

COPY Gemfile Gemfile.lock /usr/src/api/
RUN bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" --retry 5

RUN rm /usr/local/bundle/cache/*.gem
RUN find /usr/local/bundle -iname '*.o' -exec rm {} \;
RUN find /usr/local/bundle -iname '*.a' -exec rm {} \;

# RUNTIME CONTAINER
FROM ruby:2.7.2

RUN apt-get update && apt-get -y upgrade
RUN gem install bundler

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl

WORKDIR /usr/src/api
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY . /usr/src/api

ENV RAILS_LOG_TO_STDOUT true
RUN bundle install

CMD ["bin/entry"]