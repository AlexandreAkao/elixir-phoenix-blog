defmodule Pfu.Tipo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tipos" do
    field :name, :string
    has_many :users, Pfu.User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
