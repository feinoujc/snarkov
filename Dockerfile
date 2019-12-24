FROM phusion/passenger-ruby25

RUN gem install bundler -v 1.17.3

RUN apt-get update -qq \
    && rm -rf /var/lib/apt/lists/*

ENV APP_BASE_DIR /home/app

WORKDIR ${APP_BASE_DIR}
# Separate task from `add . .` as it will be
# Skipped if gemfile.lock hasn't changed
COPY Gemfile* ./

# Install gems to /bundle
RUN bundle install

ADD . .

RUN chown -R app:app ${APP_BASE_DIR}

EXPOSE 3000
