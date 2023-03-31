FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
WORKDIR /munipe_manager
COPY Gemfile /munipe_manager/Gemfile
COPY Gemfile.lock /munipe_manager/Gemfile.lock
RUN bundle install
RUN npm install -g yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
EXPOSE 9200

CMD ["rails", "server", "-b", "0.0.0.0"]