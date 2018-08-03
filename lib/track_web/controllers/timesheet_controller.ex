defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, params) do
    logs = list_logs(conn, params)
    changeset = Time.change_log()

    render(conn, "index.html", logs: logs, changeset: changeset)
  end

  def create(conn, params) do
    case Time.create_log(params) do
      {:ok, log} ->
        logs = list_logs(conn, params)
        changeset = Time.change_log()

        conn
        |> put_flash(:info, "Created")
        |> render("index.html", logs: logs, changeset: changeset)

      {:error, changeset} ->
        logs = list_logs(conn, params)

        conn
        |> put_flash(:error, "Validation error")
        |> render("index.html", logs: logs, changeset: changeset)
    end
  end

  defp list_logs(conn, params) do
    conn
    |> current_user
    |> Time.list_logs_for_user_and_date(nil)
  end
end
