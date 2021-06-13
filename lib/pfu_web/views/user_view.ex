defmodule PfuWeb.UserView do
  use PfuWeb, :view
  alias Pfu.User

  def first_name(%User{name: name}) do
    name |> String.split(" ") |> Enum.at(0)
  end

end
