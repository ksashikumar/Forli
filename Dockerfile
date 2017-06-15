FROM ruby:2.4.1

# set some rails env vars
ENV RAILS_ENV production
ENV BUNDLE_PATH /bundle

# set the app directory var
ENV APP_HOME /home/app
WORKDIR $APP_HOME

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update -qq

# Install apt dependencies

RUN apt-get install -y --no-install-recommends --fix-missing \
  build-essential \
  nodejs \
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev \
  libpq-dev \
  postgresql-client-9.4

# install bundler
RUN gem install bundler

# Separate task from `add . .` as it will be
# Skipped if gemfile.lock hasn't changed *
COPY Gemfile Gemfile.lock ./

# Install gems to /bundle
RUN bundle install
ADD . .

EXPOSE 3000

CMD ["/sbin/my_init"]