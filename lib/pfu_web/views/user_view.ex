defmodule PfuWeb.UserView do
  use PfuWeb, :view
  alias Pfu.User
  alias Pfu.Tipo
  alias Pfu.Repo

  def first_name(%User{name: name}) do
    name |> String.split(" ") |> Enum.at(0)
  end

  def get_tipo(%User{tipo_id: tipo_id}) do
    Repo.get(Tipo, tipo_id).name
  end

end
