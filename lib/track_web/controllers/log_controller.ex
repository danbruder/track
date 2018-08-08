defmodule TrackWeb.LogController do
  use TrackWeb, :controller
  import TrackWeb.SessionHelpers, only: [current_user: 1]
  alias Track.Accounts
  alias Track.Time

  def new(conn, params) do
    changeset = Time.change_log()
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"log" => log} = params) do
    case Time.create_log(log) do
      {:ok, log} ->
        changeset = Time.change_log()

        conn
        |> put_flash(:info, "Entry Saved")
        |> render("index.html", changeset: changeset)

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error saving entry")
        |> render("index.html", changeset: changeset)
    end
  end
end
