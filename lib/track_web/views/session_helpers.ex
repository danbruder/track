defmodule TrackWeb.SessionHelpers do
  alias Track.Accounts.User

  def current_user(conn) do
    conn
    |> case do
      %{assigns: %{current_user: current_user}} ->
        current_user

      _ ->
        nil
    end
  end

  def logged_in?(conn) do
    conn
    |> case do
      %{assigns: %{current_user: nil}} ->
        false

      %{assigns: %{current_user: %User{} = user}} ->
        true

      _ ->
        false
    end
  end
end
