defmodule Track.Repo.Migrations.AddBillableToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :billable, :boolean
    end
  end
end
