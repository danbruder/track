defmodule TrackWeb.LogController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias TrackWeb.Router.Helpers, as: Routes
  alias TrackWeb.Endpoint
  alias Track.Accounts
  alias Track.Time

  def show(conn, %{"id" => id}) do
    case Time.get_log(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TrackWeb.ErrorView)
        |> render("404.html")

      log ->
        conn |> render("show.html", log: log)
    end
  end

  def new(conn, params) do
    changeset = Time.change_log()

    date = params |> parse_date

    render(conn, "index.html", changeset: changeset, date: date)
  end

  def create(conn, %{"log" => log} = params) do
    case Time.create_log(log) do
      {:ok, log} ->
        changeset = Time.change_log()

        conn
        |> put_flash(:success, "Log Saved")
        |> redirect(to: Routes.timesheet_path(Endpoint, :index))

      {:error, changeset} ->
        date = params |> parse_date

        conn
        |> put_flash(:error, "Error saving Log")
        |> render("index.html", changeset: changeset)
    end
  end

  defp parse_date(%{"date" => date}), do: date
  defp parse_date(params), do: Timex.today()
end
