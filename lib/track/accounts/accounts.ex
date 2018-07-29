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
end
