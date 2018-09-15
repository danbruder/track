defmodule TrackWeb.ClientController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time
  alias TrackWeb.Helpers
  alias TrackWeb.Endpoint
  alias TrackWeb.Router.Helpers, as: Routes

  def index(conn, _params) do
    clients = Time.list_clients()
    render(conn, "index.html", clients: clients)
  end

  def new(conn, params) do
    changeset = Time.change_client()
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Show a client
  """
  def show(conn, %{"id" => id}) do
    client = Time.get_client_with_projects!(id)
    render(conn, "show.html", client: client)
  end

  def create(conn, %{"client" => client} = params) do
    case Time.create_client(client) do
      {:ok, client} ->
        changeset = Time.change_client()

        conn
        |> put_flash(:info, "Client Saved")
        |> redirect(to: Routes.client_path(Endpoint, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving client")
        |> render("new.html", changeset: changeset)
    end
  end
end
