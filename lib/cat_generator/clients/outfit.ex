defmodule CatGenerator.Clients.Outfit do
  use HTTPoison.Base

  def process_url(gender) do
    "https://adorn-thy-cat.herokuapp.com/?gender=#{gender}"
  end

  def process_response_body(body), do: body

  def fetch(gender) do
    __MODULE__.get!(gender).body
  end
end