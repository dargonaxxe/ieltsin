import Config

config :ieltsin, Ieltsin.Repo,
  database: System.get_env("IELTSIN_DB_NAME"),
  username: System.get_env("IELTSIN_DB_USERNAME"),
  password: System.get_env("IELTSIN_DB_PASSWORD"),
  hostname: System.get_env("IELTSIN_DB_HOSTNAME")

config :ieltsin, ecto_repos: [Ieltsin.Repo]
