defmodule Track.Repo.Migrations.AddInternalRateToProjectClientAndLog do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :internal_rate, :decimal
    end
    alter table(:projects) do
      add :internal_rate, :decimal
    end
    alter table(:clients) do
      add :internal_rate, :decimal
    end
  end
end
