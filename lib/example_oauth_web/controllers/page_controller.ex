defmodule ExampleOauthWeb.PageController do
  use ExampleOauthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
