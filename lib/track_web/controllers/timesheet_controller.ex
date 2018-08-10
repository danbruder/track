defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, params) do
    today = Timex.today()
    tomorrow = today |> Timex.shift(days: 1)
    yesterday = today |> Timex.shift(days: -1)

    logs =
      conn
      |> current_user
      |> Time.list_logs_for_user_and_date(today)

    render(conn, "index.html", logs: logs, today: today, tomorrow: tomorrow, yesterday: yesterday)
  end
end
