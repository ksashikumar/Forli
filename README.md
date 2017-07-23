# Forli

### Why Forli?
The first settlement of the ancient Roman Forum was built in approximately 188 BC by consul *Gaius Livius Salinator*, who gave it the Latin name *Forum Livii*, meaning "the place of the gens Livia".

### Installation Guide (Please follow links)

Forli requires:
- `Ruby version: 2.4.1 (x86_64-darwin16)`
- `Rails version: 5.1.1`
- [`Redis Server`](https://redis.io/download)
- [`PostgreSQL: 9.5`](http://postgresguide.com/setup/install.html)
- [`Elasticsearch: 5.5`](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html)

Install [`rvm`](https://rvm.io/rvm/install), `bundler`, `rails`:

```sh
$ rvm install 2.4.1
$ rvm --create use 2.4.1@forli
$ gem install bundler
```

Clone the Repo:

```sh
$ git clone git@github.com:ksashikumar/Forli.git
$ cd Forli
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

Start all services:

```sh
$ redis-server &
$ elasticsearch &
$ bundle exec sidekiq -C config/sidekiq.yml
$ bundle exec puma -C config/puma.rb -p 4000
```

The Rails API server runs in `port: 4000`

### Frontend Setup

Clone the Repo:

```sh
$ git clone git@github.com:ksashikumar/Forli-client.git
$ cd Forli-client
$ npm install
$ bower install
$ ember serve
```

The Ember frontend server runs in `port: 5050`. Once `ember serve` command starts, go to: [`http://localhost:5050`](http://localhost:5050)

### Metrics

The Sidekiq Web runs along with the Rails API server. To view the dashboard, go to: [`http://localhost:4000/sidekiq`](http://localhost:4000/sidekiq)

### Docker
```sh
$ docker-compose build
$ docker-compose run app rake db:create
$ docker-compose run app rake db:migrate
$ docker-compose up all
```
