defmodule Track.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:avatar_url, :string)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :avatar_url])
    |> validate_required([:first_name, :last_name, :email, :password, :avatar_url])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
