defmodule Track.Repo.Migrations.AddBillingOverrideToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add(:override_rates, :boolean, default: false)
    end
  end
end
