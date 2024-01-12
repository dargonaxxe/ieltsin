
FROM elixir:1.16.0-alpine

WORKDIR /app/

RUN mix local.hex --force &&\
    mix local.rebar --force 

COPY mix.exs mix.lock /app/
RUN mix deps.get

COPY . . 
ENV MIX_ENV=prod
RUN mix release 

ENV IELTSIN_DB_NAME=ieltsin \
    IELTSIN_DB_USERNAME=admin \
    IELTSIN_DB_PASSWORD=admin \
    IELTSIN_DB_HOSTNAME=localhost

CMD ["./entrypoint.sh"]
