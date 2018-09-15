defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, %{"date" => date}) do
    case Time.Helpers.parse_date(date) do
      {:ok, date} ->
        logs =
          conn
          |> current_user
          |> Time.list_logs_for_user_and_date(date)

        weekdays = [
          ~D[2018-09-10],
          ~D[2018-09-11],
          ~D[2018-09-12],
          ~D[2018-09-13],
          ~D[2018-09-14],
          ~D[2018-09-15],
          ~D[2018-09-16]
        ]

        render(conn, "index.html", logs: logs, weekdays: weekdays)

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("index.html", logs: [])
    end
  end

  def index(conn, params) do
    logs =
      conn
      |> current_user
      |> Time.list_logs_for_user_and_date(Timex.today())

    render(conn, "index.html", logs: logs)
  end
end
