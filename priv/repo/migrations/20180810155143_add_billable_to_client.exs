defmodule Track.Repo.Migrations.AddBillableToClient do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      add(:billable, :boolean, default: true)
    end
  end
end
