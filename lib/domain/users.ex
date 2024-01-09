defmodule Ieltsin.Domain.Users do
  alias Ieltsin.Data.User
  alias Ieltsin.Repo

  def create(tg_id) do
    attrs = %{tg_id: tg_id |> Integer.to_string()}
    User.new() |> User.changeset(attrs) |> Repo.insert()
  end

  def get_by_tg_id(tg_id) do
    User
    |> Repo.get_by(tg_id: tg_id |> Integer.to_string())
  end
end
