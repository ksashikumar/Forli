FROM ruby:2.4.1


FROM ruby:2.3.3

RUN apt-get update -qq

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

RUN mkdir /forli
RUN mkdir /forli/ember

WORKDIR /forli
ADD Gemfile /forli/Gemfile
ADD Gemfile.lock /forli/Gemfile.lock

# install bundler
RUN gem install bundler

RUN bundle install
ADD . /forli

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
