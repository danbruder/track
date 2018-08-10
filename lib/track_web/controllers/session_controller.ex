defmodule TrackWeb.SessionController do
  use TrackWeb, :controller
  alias Track.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    email
    |> Track.Accounts.login_by_email(password)
    |> case do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:success, "Logged in")
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> render("new.html")
    end
  end

  def create(conn, _params) do
    conn
    |> put_flash(:info, "Please enter email and password")
    |> render("new.html")
  end

  def delete(conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, "Successfully logged out")
    |> redirect(to: "/user/login")
  end
end
