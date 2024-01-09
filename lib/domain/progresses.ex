defmodule Ieltsin.Domain.Progresses do
  alias Ieltsin.Data.Progress
  alias Ieltsin.Repo

  def get_by_user_id(user_id) do
    Progress
    |> Repo.get_by(user_id: user_id)
  end
end
