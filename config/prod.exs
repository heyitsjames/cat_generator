use Mix.Config

config :cat_generator, CatGenerator.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cat_generator",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
