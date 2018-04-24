defmodule CatGenerator.Application do
  @moduledoc """
    Cat Generator OTP Application
  """

  use Application

  def start(_type, _args) do
    children = [
      CatGenerator.Repo
    ]

    opts = [strategy: :one_for_one, name: CatGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
