defmodule Track.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Track.Repo

  alias Track.Accounts.User

  def register(args) do
    %User{}
    |> User.changeset(args)
    |> Repo.insert
  end

  def login_by_email(email, password) do
    User 
    |> Repo.get_by(email: email)
    |> Comeonin.Argon2.check_pass(password)
    |> case do
      {:ok, user} ->
        {:ok, user}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
