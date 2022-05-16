FROM ruby:2.7.6

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x -o /tmp/nodesource_setup.sh && bash /tmp/nodesource_setup.sh && apt-get install nodejs
RUN npm install -g yarn

WORKDIR /app

COPY Gemfile* ./
RUN bundle config --global jobs 6 && bundle config set cache_all true && bundle cache
COPY . .
RUN yarn install
ENV BINDING 0.0.0.0
CMD bash -c "foreman start -f Procfile.dev"
