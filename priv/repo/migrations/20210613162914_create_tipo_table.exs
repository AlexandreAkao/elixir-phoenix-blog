defmodule Pfu.Repo.Migrations.CreateTipoTable do
  use Ecto.Migration

  def change do
    create table(:tipos) do
      add :name, :string

      timestamps()
    end
    create unique_index(:tipos, [:name])
  end
end
