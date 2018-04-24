defmodule CatGenerator.ModelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
      import CatGenerator.ModelCase
    end
  end

  setup tags do
    Ecto.Adapters.SQL.Sandbox.checkout(CatGenerator.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CatGenerator.Repo, {:shared, self()})
    end

    :ok
  end
end
