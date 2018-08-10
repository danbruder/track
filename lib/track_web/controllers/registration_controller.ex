defmodule TrackWeb.RegistrationController do
  use TrackWeb, :controller
  alias Track.Accounts
  alias TrackWeb.Router.Helpers, as: Routes
  alias TrackWeb.Endpoint

  def new(conn, _params) do
    render(conn, "new.html", changeset: Accounts.registration_change())
  end

  def create(
        conn,
        %{"user" => user} = args
      ) do
    Accounts.register(user)
    |> case do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Registered!")
        |> redirect(to: Routes.page_path(Endpoint, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong...")
        |> render("new.html", changeset: changeset)
    end
  end

  def create(conn, _params) do
    conn
    |> put_flash(:error, "Please enter email and password")
    |> render("new.html")
  end
end
