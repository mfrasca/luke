# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :luke,
  ecto_repos: [Luke.Repo]

# Configures the endpoint
config :luke, LukeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3LdMXnVuiV7Hp1pLYsux8B1Z64/DUmIdKZLA3XMqDGcTTe/P3T85wPgmJVE82+b7",
  render_errors: [view: LukeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Luke.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
