defmodule CatGeneratorTest do
  use CatGenerator.ModelCase
  use Mockery
  use ExUnitProperties

  alias CatGenerator.{
    Breeds,
    Cat,
    Names,
    Qualities,
    Repo
  }

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
      mock(CatGenerator.Clients.Image, [fetch: 0], "http://butts.gov/cat.tiff")

      cat = CatGenerator.generate(with_image: true)

      assert Enum.sort(Map.keys(Cat.present(cat))) == @cat_fields
      assert cat.image_url == "http://butts.gov/cat.tiff"
    end

    test "generate a cat with an outfit" do
      mock(CatGenerator.Clients.Outfit, [fetch: 1], "A very nice outfit")

      cat = CatGenerator.generate(with_adornment: true)

      assert Enum.sort(Map.keys(Cat.present(cat))) == @cat_fields
      assert cat.adornment == "A very nice outfit"
    end

    test "generate a cat with an outfit and an image" do
      mock(CatGenerator.Clients.Outfit, [fetch: 1], "A very nice outfit")
      mock(CatGenerator.Clients.Image, [fetch: 0], "http://butts.gov/cat.tiff")

      cat = CatGenerator.generate(with_adornment: true, with_image: true)

      assert Enum.sort(Map.keys(Cat.present(cat))) == @cat_fields
      assert cat.adornment == "A very nice outfit"
      assert cat.image_url == "http://butts.gov/cat.tiff"
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
      mock(CatGenerator.Clients.Outfit, [fetch: 1], "A very nice outfit.")

      cat = CatGenerator.generate()
      adorned_cat = CatGenerator.adorn(cat)

      assert adorned_cat.adornment == "A very nice outfit."
    end
  end

  describe "CatGenerator.cucumber/1" do
    property "cucumbers the cat so hard, but safely so we don't accidentally kill it" do
      check all name <- member_of(Names.names()),
                breed <- member_of(Breeds.breeds()),
                qualities <-
                  list_of(member_of(Qualities.safe_qualities()), min_length: 1, max_length: 5),
                gender <- member_of(["male", "female"]) do
        attrs = %{
          name: name,
          breed: breed,
          qualities: qualities |> Cat.prepare_qualities(),
          gender: gender
        }

        changeset = Cat.changeset(%Cat{}, attrs)
        cat = Repo.insert!(changeset)

        message = CatGenerator.cucumber(cat)

        cucumbered_cat = Repo.get(Cat, cat.id)

        assert cucumbered_cat.alive
        assert message == "OMG LOL WOW! You just cucumbered that cat! It's going so crazy rn!"
      end
    end

    property "cucumbers the cat so hard that it dies, unfortunately" do
      check all name <- member_of(Names.names()),
                breed <- member_of(Breeds.breeds()),
                qualities <-
                  list_of(member_of(Qualities.lethal_qualities()), min_length: 1, max_length: 5),
                gender <- member_of(["male", "female"]) do
        attrs = %{
          name: name,
          breed: breed,
          qualities: qualities |> Cat.prepare_qualities(),
          gender: gender
        }

        changeset = Cat.changeset(%Cat{}, attrs)
        cat = Repo.insert!(changeset)

        message = CatGenerator.cucumber(cat)

        cucumbered_cat = Repo.get(Cat, cat.id)

        refute cucumbered_cat.alive
        assert message == "Well. You just cucumbered that cat to death. RIP in peace, cat."
      end
    end
  end
end
