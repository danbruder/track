defmodule Track.Time.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:bill_rate, :decimal)
    field(:internal_rate, :decimal)
    field(:name, :string)
    field(:billable, :boolean, default: true)
    field(:override_rates, :boolean, default: false)
    belongs_to(:client, Track.Time.Client)
    has_many(:logs, Track.Time.Log)

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:internal_rate, :name, :bill_rate, :billable, :client_id, :override_rates])
    |> validate_required([:name, :billable])
  end
end
