defmodule NewAppWeb.PageController do
  use NewAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
