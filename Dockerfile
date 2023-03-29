FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
WORKDIR /munipe_manager
COPY Gemfile /munipe_manager/Gemfile
COPY Gemfile.lock /munipe_manager/Gemfile.lock
RUN bundle install
RUN npm install -g yarn
RUN apt-get update -qq && apt-get install -y default-jdk
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.3.0-amd64.deb
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.3.0-amd64.deb.sha512
RUN shasum -a 512 -c elasticsearch-7.3.0-amd64.deb.sha512
RUN dpkg -i elasticsearch-7.3.0-amd64.deb

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]