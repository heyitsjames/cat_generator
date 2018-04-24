defmodule CatGenerator do
  alias CatGenerator.{
    Breeds,
    Names,
    Qualities,
    Cat,
    Repo
  }

  @moduledoc """
  Cat generator
  """

  @image_service Mockery.of("CatGenerator.Clients.Image")
  @outfit_service Mockery.of("CatGenerator.Clients.Outfit")

  def generate(opts \\ []) do
    with_image? = Keyword.get(opts, :with_image, false)

    image_url = if with_image?, do: @image_service.fetch(), else: ""

    attrs = %{
      name: Names.take_one(),
      breed: Breeds.take_one(),
      qualities: 1..5 |> Enum.random() |> Qualities.take() |> Cat.prepare_qualities(),
      gender: ["male", "female"] |> Enum.take_random(1) |> List.first,
      image_url: image_url
    }

    changeset = Cat.changeset(%Cat{}, attrs)

    if changeset.valid? do
      Repo.insert!(changeset)
    else
      changeset.errors
    end
  end

  def get_image(cat) do
    image_url = @image_service.fetch()

    changeset = Cat.changeset(cat, %{image_url: image_url})

    if changeset.valid? do
      Repo.update!(changeset)
    else
      changeset.errors
    end
  end

  def adorn(cat) do
    adornment = @outfit_service.fetch(cat.gender)

    changeset = Cat.changeset(cat, %{adornment: adornment})

    if changeset.valid? do
      Repo.update!(changeset)
    else
      changeset.errors
    end
  end

  def declaw(cat) do
    changeset = Cat.changeset(cat, %{declawed_at: DateTime.utc_now()})

    if changeset.valid? do
      Repo.update!(changeset)
    else
      changeset.errors
    end
  end

  def fix(cat) do
    changeset = Cat.changeset(cat, %{fixed_at: DateTime.utc_now()})

    if changeset.valid? do
      Repo.update!(changeset)
    else
      changeset.errors
    end
  end

  def pet(cat) do
    incrementor = cat.number_of_times_petted + 1
    changeset = Cat.changeset(cat, %{number_of_times_petted: incrementor})

    if changeset.valid? do
      Repo.update!(changeset)
    else
      changeset.errors
    end
  end
end
