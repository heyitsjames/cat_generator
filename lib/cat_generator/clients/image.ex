defmodule CatGenerator.Clients.Image do
  require Logger
  use HTTPoison.Base
  import SweetXml

  def process_response_body(body) do
    body
    |> xpath(~x"//url/text()")
    |> List.to_string()
  end

  def fetch() do
    if Mix.env == :test do
      Logger.warn("Hey! Don't make network requests in your tests!!!")
    else
      __MODULE__.get!("http://thecatapi.com/api/images/get?format=xml&size=small").body
    end
  end
end