defmodule LukeWeb.PageControllerTest do
  use LukeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Luke!"
  end
end
