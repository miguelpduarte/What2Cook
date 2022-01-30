defmodule What2cookWeb.PageController do
  use What2cookWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
