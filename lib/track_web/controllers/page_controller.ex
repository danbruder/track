defmodule TrackWeb.PageController do
  use TrackWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
