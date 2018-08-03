defmodule TrackWeb.SessionHelpers do
  def current_user(conn) do
    conn
    |> Plug.Conn.get_session(:current_user)
    |> Track.Accounts.get_user_by_id()
  end

  def logged_in?(conn) do
    conn
    |> Plug.Conn.get_session(:current_user)
    |> case do
      id when is_number(id) ->
        true

      _ ->
        false
    end
  end
end
