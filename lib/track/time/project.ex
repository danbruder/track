defmodule Track.Time.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:bill_rate, :decimal)
    field(:internal_rate, :decimal)
    field(:name, :string)
    field(:billable, :boolean)
    belongs_to(:client, Track.Time.Client)
    belongs_to(:user, Track.Accounts.User)
    has_many(:logs, Track.Time.Log)

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:internal_rate, :name, :bill_rate, :billable, :client_id])
    |> validate_required([:name, :billable])
  end
end
