defmodule Track.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :description, :string
      add :hours, :decimal
      add :date, :date
      add :billable, :boolean, default: false, null: false
      add :bill_rate, :decimal
      add :opportunity_cost, :decimal
      add :internal_cost, :decimal
      add :profit, :decimal
      add :billed, :boolean, default: false, null: false
      add :project_id, references(:projects, on_delete: :nothing)
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:logs, [:project_id])
    create index(:logs, [:client_id])
  end
end
