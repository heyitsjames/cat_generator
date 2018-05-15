use Mix.Config

config :logger, backends: [], level: :warn

config :cat_generator, CatGenerator.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cat_generator_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
