use Mix.Config

config :cat_generator, :ecto_repos, [CatGenerator.Repo]
config :cat_generator, CatGenerator.Repo, migration_timestamps: [type: :utc_datetime]

import_config "#{Mix.env()}.exs"
