defmodule Track.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :avatar_url])
    |> validate_required([:first_name, :last_name, :email, :password, :avatar_url])
  end
end
