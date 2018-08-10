defmodule Track.Time.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field(:name, :string)
    field(:bill_rate, :decimal)
    field(:internal_rate, :decimal)
    belongs_to(:user, Track.Accounts.User)
    has_many(:projects, Track.Time.Project)
    has_many(:logs, Track.Time.Log)

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :bill_rate, :internal_rate])
    |> validate_required([:name])
  end
end
