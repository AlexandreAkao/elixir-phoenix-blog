defmodule Pfu.Repo do
  use Ecto.Repo, otp_app: :pfu, adapter: Ecto.Adapters.Postgres

  #def tudo(Pfu.User) do
  #  [%Pfu.User{id: "1", name: "Manoel Silva", username: "manoel", password: "elixir"},
  #  %Pfu.User{id: "2", name: "Pedro Costa", username: "pedro", password: "lang"},
  #  %Pfu.User{id: "3", name: "Maria Oliveira", username: "maria", password: "phx"}]
  #end
  # manoel = %User{name: "Manoel Silva", username: "manoel", password_hash: "elixir"}
  # pedro  = %User{name: "Pedro Costa", username: "pedro", password_hash: "lang"}
  # maria = %User{name: "Maria Oliveira", username: "maria", password_hash: "phx"}

  #def tudo(_module), do: []

  #observar a ordem de sobrecarga
  #def pega_by_id(module, id="1") do
  #  IO.inspect("sobrecarga e padrao 1")
  #  Enum.find tudo(module), fn map -> map.id == id end
  #end

  #def pega_by_id(module, id) do
  #  Enum.find tudo(module), fn map -> map.id == id end
  #end

  #def pega_by_value(module, params) do
  #  Enum.find tudo(module), fn map ->
  #    Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
  #  end
  #end
end
