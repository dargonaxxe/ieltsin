defmodule Ieltsin.Domain.Users do
  require Logger
  alias Ieltsin.Data.Progress
  alias Ieltsin.Data.User
  alias Ieltsin.Repo

  @progress_attrs %{quarters_left: 500 * 4}
  def create(tg_id) do
    attrs = %{tg_id: tg_id |> Integer.to_string()}

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:user, User.new() |> User.changeset(attrs))
    |> Ecto.Multi.insert(
      :progress,
      fn %{user: user} ->
        progress_attrs = @progress_attrs |> Map.put(:user_id, user.id)
        Progress.new() |> Progress.create_changeset(progress_attrs)
      end
    )
    |> Repo.transaction()
  end

  def get_by_tg_id(tg_id) do
    User
    |> Repo.get_by(tg_id: tg_id |> Integer.to_string())
  end
end
