defmodule LukeWeb.CountController do
  use LukeWeb, :controller

  def index(conn, _params) do
    users = %{"__total__" => 0}
    json conn, users
  end
end
