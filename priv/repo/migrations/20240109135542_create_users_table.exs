defmodule Ieltsin.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("tg_users") do
      add :tg_id, :binary
    end

    create unique_index("tg_users", [:tg_id])
  end
end
