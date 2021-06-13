defmodule Pfu.Repo.Migrations.AddTipoIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :tipo_id, references(:tipos, on_delete: :delete_all), null: false
    end
  end
end
