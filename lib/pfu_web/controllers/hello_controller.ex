defmodule PfuWeb.HelloController do
  use PfuWeb, :controller

  def world(conn, %{"name" => name}) do
    render conn, "world.html", name: name
  end

end
