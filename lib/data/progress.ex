defmodule Ieltsin.Data.Progress do
  alias Ieltsin.Data.User
  use Ecto.Schema

  schema "progresses" do
    belongs_to(:user, User)
    field(:quarters_left, :integer)
  end

  def new() do
    %__MODULE__{}
  end

  import Ecto.Changeset

  def create_changeset(progress, attrs) do
    progress
    |> cast(attrs, [:user_id, :quarters_left])
    |> validate_required([:user_id, :quarters_left])
  end

  def update_changeset(progress, attrs) do
    progress
    |> cast(attrs, [:quarters_left])
    |> validate_required([:quarters_left])
  end
end
