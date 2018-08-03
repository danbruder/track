defmodule TrackWeb.SessionController do
  use TrackWeb, :controller
  alias Track.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    email
    |> String.downcase()
    |> Track.Accounts.login_by_email(password)
    |> case do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/user")

      {:error, reason} ->
        IO.puts(reason)

        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def create(conn, _params) do
    conn
    |> put_flash(:info, "Please enter email and password")
    |> render("new.html")
  end
end
