#!/bin/sh

mix ecto.create 
mix ecto.migrate 
/app/_build/prod/rel/ieltsin/bin/ieltsin start 
