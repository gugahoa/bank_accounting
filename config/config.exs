# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank_accounting,
  ecto_repos: [BankAccounting.Repo]

# Configures the endpoint
config :bank_accounting, BankAccountingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Rz8LJD7xKhbbMJv4wEbUQbSIJ4P8O4DdlD4qt3jVpheWieoe7H42dHK2LPezS12m",
  render_errors: [view: BankAccountingWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankAccounting.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "cwTi3R8b"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
