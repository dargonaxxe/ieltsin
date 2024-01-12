
FROM elixir:1.16.0

WORKDIR /app/

RUN mix local.hex --force &&\
    mix local.rebar --force 

COPY mix.exs mix.lock /app/
RUN mix deps.get

COPY . . 
RUN mix release 

ENV IELTSIN_DB_NAME=ieltsin \
    IELTSIN_DB_USERNAME=admin \
    IELTSIN_DB_PASSWORD=admin \
    IELTSIN_DB_HOSTNAME=localhost

CMD ["/app/_build/prod/rel/ieltsin/app/bin/ieltsin", "start"]
