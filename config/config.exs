# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :track,
  ecto_repos: [Track.Repo]

# Configures the endpoint
config :track, TrackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+vKbW8FqSLDrzQqD9DdeOwC6UuudZ0OGA2UVoowSdo1aPTkJ0Xry0lPB8YZaj3Pz",
  render_errors: [view: TrackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Track.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
