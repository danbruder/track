defmodule Track.Accounts.Org do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orgs" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
