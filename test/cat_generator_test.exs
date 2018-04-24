defmodule CatGeneratorTest do
  use CatGenerator.ModelCase
  use Mockery

  alias CatGenerator.Cat

  @cat_fields [
    :adornment,
    :alive,
    :breed,
    :declawed,
    :fixed,
    :gender,
    :image_url,
    :name,
    :number_of_times_petted,
    :qualities
  ]

  @epoch DateTime.from_unix!(0)

  describe "CatGenerator.generate/0" do
    test "generates a cat" do
      cat = CatGenerator.generate()
      assert Enum.sort(Map.keys(Cat.present(cat))) == @cat_fields
    end

    test "generate a cat with an image url" do
      mock CatGenerator.Clients.Image, [fetch: 0], "http://butts.gov/cat.tiff"

      cat = CatGenerator.generate()
      cat_with_image = CatGenerator.get_image(cat)

      assert cat_with_image.image_url == "http://butts.gov/cat.tiff"
    end
  end

  describe "CatGenerator.pet/1" do
    test "pets the cat once" do
      cat = CatGenerator.generate()
      
      assert cat.number_of_times_petted == 0

      petted_cat = CatGenerator.pet(cat)

      assert petted_cat.number_of_times_petted == 1
    end
  end

  describe "CatGenerator.fix/1" do
    test "fixes the cat" do
      cat = CatGenerator.generate()
      fixed_cat = CatGenerator.fix(cat)

      assert fixed_cat.fixed_at > @epoch
    end
  end

  describe "CatGenerator.declaw/1" do
    test "declaws the cat" do
      cat = CatGenerator.generate()
      declawed_cat = CatGenerator.declaw(cat)

      assert declawed_cat.declawed_at > @epoch
    end
  end

  describe "CatGenerator.adorn/1" do
    test "adorns a cat in a beautiful wardrobe" do
      mock CatGenerator.Clients.Outfit, [fetch: 1], "A very nice outfit."

      cat = CatGenerator.generate()
      adorned_cat = CatGenerator.adorn(cat)

      assert adorned_cat.adornment == "A very nice outfit."
    end
  end

  describe "CatGenerator.cucumber/0" do
    test "cucumbers the cat" do
      cat = CatGenerator.generate()
      adorned_cat = CatGenerator.adorn(cat)

      assert adorned_cat.adornment == "A very nice outfit."
    end
  end
end
