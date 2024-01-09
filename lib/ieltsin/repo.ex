defmodule Ieltsin.Repo do
  use Ecto.Repo,
    otp_app: :ieltsin,
    adapter: Ecto.Adapters.Postgres
end
