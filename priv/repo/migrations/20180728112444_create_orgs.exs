defmodule Track.Repo.Migrations.CreateOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :name, :string

      timestamps()
    end

  end
end
