defmodule TrackWeb.Plugs.ProjectsExist do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  alias Track.Time

  def init(opts), do: opts

  def call(conn, opts) do
    if Time.projects_exist?() do
      conn
    else
      conn
      |> put_flash(:info, opts)
      |> redirect(to: TrackWeb.Router.Helpers.project_path(TrackWeb.Endpoint, :new))
      |> halt()
    end
  end
end
