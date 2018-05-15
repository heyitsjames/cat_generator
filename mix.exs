defmodule CatGenerator.MixProject do
  use Mix.Project

  @apps [
    :logger
  ]

  def project do
    [
      app: :cat_generator,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: apps(Mix.env()),
      mod: {CatGenerator.Application, []}
    ]
  end

  # Specifies which apps should be started for each environment
  defp apps(:test), do: [:stream_data | @apps]
  defp apps(_), do: @apps

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.2.10"},
      {:postgrex, ">= 0.0.0"},
      {:sweet_xml, "~> 0.6.5"},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.0"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:stream_data, "~> 0.1", only: :test},
      {:mockery, "~> 2.1", runtime: false}
    ]
  end
end
