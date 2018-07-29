defmodule TrackWeb.PageControllerTest do
  use TrackWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Track"
  end
end
