defmodule CatGeneratorTest do
  use CatGenerator.ModelCase
  use Mockery

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

  describe "CatGenerator.generate/0" do
    test "generates a cat" do
      mock CatGenerator.Clients.Image, [fetch: 0], "http://wownice.gov/cat.png"

      cat = CatGenerator.generate()
      assert Enum.sort(Map.keys(cat)) == @cat_fields
    end

    @tag :skip
    test "a generated cat has an image url" do
      
    end
  end

  describe "CatGenerator.pet/0" do
    
  end

  describe "CatGenerator.fix/0" do
    
  end

  describe "CatGenerator.declaw/0" do
    
  end

  describe "CatGenerator.adorn/0" do
    
  end

  describe "CatGenerator.cucumber/0" do
    
  end
end
