defmodule Track.Time.Client do
  use Ecto.Schema
  import Ecto.Changeset


  schema "clients" do
    field :name, :string
    field :bill_rate, :decimal
    has_many(:projects, Track.Time.Project)

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :bill_rate])
    |> validate_required([:name])
  end
end
