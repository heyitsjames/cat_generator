defmodule CatGenerator.Repo.Migrations.AddQuality do
  use Ecto.Migration

  def change do
    create table(:qualities) do
      add :name, :string, null: false
      add :cat_id, references(:cats), on_delete: :delete_alll, null: false

      timestamps()
    end
  end
end
