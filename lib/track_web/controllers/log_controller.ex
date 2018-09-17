defmodule TrackWeb.LogController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time

  def new(conn, params) do
    changeset = Time.change_log()

    date =
      case params do
        %{"date" => date} ->
          date

        _ ->
          Timex.today()
      end

    render(conn, "index.html", changeset: changeset, date: date)
  end

  def create(conn, %{"log" => log} = params) do
    case Time.create_log(log) do
      {:ok, log} ->
        changeset = Time.change_log()

        conn
        |> put_flash(:success, "Log Saved")
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
