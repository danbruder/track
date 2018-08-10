defmodule TrackWeb.ClientController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time
  alias TrackWeb.Helpers

  def index(conn, _params) do
    clients = Time.list_clients()
    render(conn, "index.html", clients: clients)
  end

  def new(conn, params) do
    changeset = Time.change_client()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client} = params) do
    case Time.create_client(client) do
      {:ok, client} ->
        changeset = Time.change_client()

        conn
        |> put_flash(:info, "Client Saved")
        |> render("new.html", changeset: changeset)

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving client")
        |> render("new.html", changeset: changeset)
    end
  end
end
