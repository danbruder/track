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
    |> Repo.insert()
  end

  def login_by_email(email, password) do
    with {:ok, user} <- get_user_by_email(email),
         {:ok, user} <- Comeonin.Argon2.check_pass(user, password) do
      {:ok, user}
    else
      {:error, reason} ->
        {:error, reason}

      error ->
        IO.inspect(error)
        {:error, "Could not log in. Check your email or password and try again."}
    end
  end

  def get_user_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "Could not find email"}

      user ->
        {:ok, user}
    end
  end

  def registration_change do
    User.changeset(%User{}, %{})
  end

  def get_user_by_id(id) do
    case id do
      id when is_number(id) ->
        Repo.get(User, id)

      _ ->
        nil
    end
  end

  def get_user_by_id(_) do
    nil
  end
end
