defmodule LukeWeb.CountController do
  use LukeWeb, :controller

  def index(conn, _params) do
    sleeping = :crypto.rand_uniform(500, 5000)
    :timer.sleep(sleeping)
    result = %{"__total__" => sleeping}
    json conn, result
  end
end

