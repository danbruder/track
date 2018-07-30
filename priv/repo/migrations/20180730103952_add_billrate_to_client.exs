defmodule Track.Repo.Migrations.AddBillrateToClient do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      add :bill_rate, :decimal
    end
  end
end
