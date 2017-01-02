# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :forex_fun, account_id: "101-001-4967636-001"

# Configures the endpoint
config :forex_fun, ForexFun.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cvkbzDizJgX11cPpPGSN+v8wngsBhb1OPGEzLnC6VKrW18QSAEVSm7cVV53QQWZH",
  render_errors: [view: ForexFun.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ForexFun.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
