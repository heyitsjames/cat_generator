defmodule CatGenerator.Repo.Migrations.AddCat do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add :name, :string, null: false
      add :gender, :string, null: false
      add :image_url, :string, null: false
      add :number_of_times_petted, :integer, default: 0
      add :breed, :string, null: false
      add :fixed_at, :utc_datetime, default: "epoch"
      add :declawed_at, :utc_datetime, default: "epoch"
      add :alive, :boolean, default: true
      add :adornment, :text, default: ""

      timestamps()
    end
  end
end
