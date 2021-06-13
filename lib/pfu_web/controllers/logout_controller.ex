defmodule PfuWeb.LogoutController do
  use PfuWeb, :controller
  alias PfuWeb.Auth

  plug :authenticate_user when action in [:index]

  def index(conn, _params) do
    conn
    |> Auth.logout
    |> redirect(to: "/users/new")
    #|> redirect(to: Routes.page_path(conn, :index))
  end

  #def world(conn, %{"name" => name}) do
  #  render conn, "world.html", name: name
  #
  #end

end
