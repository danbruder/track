defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, params) do
    logs =
      conn
      |> current_user
      |> Time.list_logs_for_user_and_date(nil)

    render(conn, "index.html", logs: logs)
  end
end
