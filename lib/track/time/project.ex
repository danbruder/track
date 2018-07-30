defmodule Track.Time.Project do
  use Ecto.Schema
  import Ecto.Changeset


  schema "projects" do
    field :bill_rate, :decimal
    field :name, :string
    field :billable, :boolean
    belongs_to(:client, Track.Time.Client)
    belongs_to(:user, Track.Accounts.User)
    has_many(:logs, Track.Time.Log)

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :bill_rate, :billable, :client_id, :user_id])
    |> validate_required([:name, :bill_rate, :billable, :user_id])
  end
end
