defmodule Track.Repo.Migrations.AddUserIdsToProjectsLogsAndClients do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :user_id, references(:users, on_delete: :nothing)
    end
    alter table(:clients) do
      add :user_id, references(:users, on_delete: :nothing)
    end
    alter table(:logs) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
