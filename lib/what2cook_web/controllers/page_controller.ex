defmodule What2CookWeb.PageController do
  use What2CookWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
