defmodule TrackWeb.RegistrationController do
  use TrackWeb, :controller
  alias Track.Accounts

  def new(conn, _params) do
    render(conn, "new.html", changeset: Accounts.registration_change())
  end

  def create(conn, %{"email" => email, "password" => password} = args) do
    Accounts.register(email, password, args.first_name, args.last_name)
    |> case do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Registered!")
        |> redirect(to: "/user")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Something went wrong...")
        |> render("new.html")
    end
  end

  def create(conn, _params) do
    conn
    |> put_flash(:error, "Please enter email and password")
    |> render("new.html")
  end
end
