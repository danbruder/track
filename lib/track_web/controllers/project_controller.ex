defmodule TrackWeb.ProjectController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time

  def index(conn, _params) do
    projects = Time.list_projects()

    render(conn, "index.html", projects: projects)
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
        |> render("index.html", changeset: changeset)

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving project")
        |> render("index.html", changeset: changeset)
    end
  end
end
