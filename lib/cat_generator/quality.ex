defmodule CatGenerator.Quality do
  use Ecto.Schema
  import Ecto.Changeset

  alias CatGenerator.Cat

  @timestamps_opts [type: :utc_datetime]

  @fields [
    :name,
  ]

  schema "qualities" do
    field :name, :string

    belongs_to :cat, Cat

    timestamps()
  end

  def changeset(cat, params \\ %{}) do
    cat
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end 