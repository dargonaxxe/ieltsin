defmodule Ieltsin.Repo.Migrations.CreateProgressTable do
  use Ecto.Migration

  def change do
    create table("progresses") do
      add(:user_id, references("tg_users"))
      add(:quarters_left, :integer)
    end

    create(unique_index("progresses", :user_id))
  end
end
