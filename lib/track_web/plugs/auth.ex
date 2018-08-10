defmodule TrackWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: TrackWeb.Router.Helpers.session_path(TrackWeb.Endpoint, :new))
      |> halt()
    end
  end
end
