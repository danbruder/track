defmodule Track.Repo.Migrations.AddRevenueToLog do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :revenue, :decimal
    end
  end
end
