FROM ruby:3.4

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    python3 \
    python3-pip \
    && pip3 install jupyter --break-system-packages \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /site

RUN gem install bundler

COPY Gemfile ./

RUN bundle lock --add-platform aarch64-linux-gnu
RUN bundle install

EXPOSE 4000 35729

CMD ["bundle", "exec", "jekyll", "serve", \
     "--host", "0.0.0.0", \
     "--livereload"]