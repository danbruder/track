defmodule TrackWeb.LogController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time

  def new(conn, params) do
    # check to see if there is a client and project first
    changeset = Time.change_log()

    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"log" => log} = params) do
    case Time.create_log(log) do
      {:ok, log} ->
        changeset = Time.change_log()

        conn
        |> put_flash(:info, "Log Saved")
        |> render("index.html", changeset: changeset)

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving Log")
        |> render("index.html", changeset: changeset)
    end
  end

  def create_project_first(conn, params) do
    render(conn, "create_project_first.html")
  end

  def create_client_first(conn, params) do
    render(conn, "create_client_first.html")
  end
end
