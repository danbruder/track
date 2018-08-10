defmodule Track.Repo.Migrations.RemoveUserFromProjectAndClient do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      remove(:user_id)
    end

    alter table(:projects) do
      remove(:user_id)
    end
  end
end
