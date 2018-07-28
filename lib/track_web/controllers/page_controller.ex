defmodule TrackWeb.PageController do
  use TrackWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def hello(conn, %{"name" => name}) do
    render conn, "hello.html", name: name 
  end
end
