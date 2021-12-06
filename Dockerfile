FROM ruby:2.7
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /horse_racing_forecast_bbs_api
WORKDIR /horse_racing_forecast_bbs_api
COPY Gemfile /horse_racing_forecast_bbs_api/Gemfile
COPY Gemfile.lock /horse_racing_forecast_bbs_api/Gemfile.lock
RUN bundle install
COPY . /horse_racing_forecast_bbs_api

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]