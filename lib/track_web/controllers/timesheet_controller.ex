defmodule TrackWeb.TimesheetController do
  use TrackWeb, :controller
  alias Track.Accounts
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Time

  def index(conn, %{"date" => date}) do
    case Time.Helpers.parse_date(date) do
      {:ok, date} ->
        conn
        |> index_for_date(date)

      {:error, :invalid_format} ->
        conn
        |> put_flash(:info, "The date provided is in an invalid format")
        |> index_without_logs

      {:error, message} ->
        conn
        |> put_flash(:info, message)
        |> index_without_logs
    end
  end

  def index(conn, params) do
    conn
    |> index_for_date(Timex.today())
  end

  defp index_for_date(conn, date) do
    dates =
      date
      |> Time.Helpers.dates_this_week_from_date()

    week_links = Time.Helpers.first_date_of_week_from_date_with_prev_and_next(date)

    logs =
      conn
      |> current_user
      |> Time.list_logs_for_user_and_date(date)

    conn
    |> render("index.html", logs: logs, dates: dates, date: date, week_links: week_links)
  end

  defp index_without_logs(conn) do
    dates =
      Timex.today()
      |> Time.Helpers.dates_this_week_from_date()

    week_links = Time.Helpers.first_date_of_week_from_date_with_prev_and_next(Timex.today())

    conn
    |> render("index.html", logs: [], dates: dates, date: Timex.today(), week_links: week_links)
  end
end
