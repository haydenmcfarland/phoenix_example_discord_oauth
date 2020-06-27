FROM elixir:latest

RUN apt-get update && apt-get install -y postgresql-client

RUN mix local.hex --force
RUN mix local.rebar --force

RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

WORKDIR /app
EXPOSE 4000
