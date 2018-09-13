defmodule TrackWeb.ProjectController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time
  alias TrackWeb.Router.Helpers, as: Routes
  alias TrackWeb.Endpoint

  def index(conn, _params) do
    clients_with_projects = Time.list_clients()

    render(conn, "index.html", clients: clients_with_projects)
  end

  def new(conn, params) do
    changeset = Time.change_project()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project} = params) do
    case Time.create_project(project) do
      {:ok, project} ->
        changeset = Time.change_project()

        conn
        |> put_flash(:info, "Project Saved")
        |> redirect(to: Routes.project_path(Endpoint, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving project")
        |> render("new.html", changeset: changeset)
    end
  end
end
