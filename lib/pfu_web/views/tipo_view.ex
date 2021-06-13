defmodule PfuWeb.TipoView do
  use PfuWeb, :view
  alias Pfu.Tipo

  def name(%Tipo{name: name}) do
    name |> String.split(" ") |> Enum.at(0)
  end

end
