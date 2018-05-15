defmodule CatGenerator.Cat do
  alias CatGenerator.Quality

  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  @epoch DateTime.from_unix!(0)

  @fields [
    :name,
    :gender,
    :number_of_times_petted,
    :image_url,
    :breed,
    :fixed_at,
    :declawed_at,
    :alive,
    :adornment
  ]

  @required_fields [
    :name,
    :gender,
    :breed
  ]

  @presentation_fields [
    :name,
    :gender,
    :number_of_times_petted,
    :image_url,
    :breed,
    :alive,
    :adornment
  ]

  schema "cats" do
    field(:name, :string)
    field(:gender, :string)
    field(:breed, :string)
    field(:image_url, :string, default: "")
    field(:number_of_times_petted, :integer, default: 0)
    field(:fixed_at, :utc_datetime, default: @epoch)
    field(:declawed_at, :utc_datetime, default: @epoch)
    field(:alive, :boolean, default: true)
    field(:adornment, :string, default: "")

    has_many(:qualities, Quality)

    timestamps()
  end

  def changeset(cat, params \\ %{}) do
    cat
    |> cast(params, @fields)
    |> cast_assoc(:qualities)
    |> validate_required(@required_fields)
    |> validate_inclusion(:gender, ["male", "female"])
  end

  def prepare_qualities(qualities) do
    Enum.map(qualities, fn quality ->
      %{
        name: quality
      }
    end)
  end

  def present(cat) do
    cat
    |> Map.take(@presentation_fields)
    |> Map.put(:fixed, cat.fixed_at > @epoch)
    |> Map.put(:declawed, cat.fixed_at > @epoch)
    |> Map.put(:qualities, Enum.map(cat.qualities, & &1.name))
  end
end
