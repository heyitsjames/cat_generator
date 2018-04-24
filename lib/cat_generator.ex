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

  def generate do
    IO.inspect(@image_service)
    attrs = %{
      name: Names.take_one(),
      breed: Breeds.take_one(),
      qualities: 1..5 |> Enum.random() |> Qualities.take(),
      gender: ["male", "female"] |> Enum.take_random(1) |> List.first,
      image_url: @image_service.fetch()
    }

    changeset = Cat.changeset(%Cat{}, attrs)

    if changeset.valid? do
      cat = Repo.insert!(changeset)
      Cat.present(cat)
    else
      changeset.errors
    end
  end
end
