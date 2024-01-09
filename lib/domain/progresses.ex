defmodule Ieltsin.Domain.Progresses do
  alias Ieltsin.Data.Progress
  alias Ieltsin.Repo

  def get_by_user_id(user_id) do
    Progress
    |> Repo.get_by(user_id: user_id)
  end

  def reduce(user_id) do
    progress =
      user_id
      |> get_by_user_id()

    progress
    |> Progress.update_changeset(%{quarters_left: progress.quarters_left - 1})
    |> Repo.update()
  end

  def increase(user_id) do
    progress = user_id |> get_by_user_id()

    progress
    |> Progress.update_changeset(%{quarters_left: progress.quarters_left + 1})
    |> Repo.update()
  end
end
