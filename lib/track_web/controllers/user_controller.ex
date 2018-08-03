defmodule TrackWeb.UserController do
  use TrackWeb, :controller
  alias Track.Accounts

  def index(conn, _params) do
    conn
    |> get_session(:current_user)
    |> IO.inspect()

    render(conn, "index.html")
  end
end
