defmodule Ieltsin.Data.User do
  use Ecto.Schema

  schema "tg_users" do
    field(:tg_id, :binary)
  end

  import Ecto.Changeset

  def new() do
    %__MODULE__{}
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:tg_id])
    |> validate_required([:tg_id])
  end
end
