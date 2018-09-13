defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, params) do
    logs = Track.Time.list_logs()
    render(conn, "index.html", logs: logs)
  end
end
