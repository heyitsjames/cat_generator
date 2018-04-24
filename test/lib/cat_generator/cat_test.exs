defmodule CatGenerator.CatTest do
  use CatGenerator.ModelCase

  alias CatGenerator.Cat

  describe "Cat.present/1" do
    test "makes a nice presentable map" do
      attrs = %{
        name: "Nice cat",
        gender: "male",
        breed: "Some breed",
        image_url: "http://wow.gov/cat.jpg",
        qualities: ["test"]
      }

      changeset = Cat.changeset(%Cat{}, attrs)
      assert changeset.valid?
      cat = apply_changes(changeset)

      assert %{
        adornment: "",
        alive: true,
        breed: "Some breed",
        declawed: false,
        fixed: false,
        gender: "male",
        image_url: "http://wow.gov/cat.jpg",
        name: "Nice cat",
        number_of_times_petted: 0,
        qualities: ["test"]
      } = Cat.present(cat)
    end
  end
end