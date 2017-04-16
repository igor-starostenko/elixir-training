# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pchat,
  ecto_repos: [Pchat.Repo]

# Configures the endpoint
config :pchat, Pchat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Uas/uZaA3jXpAja2PhIdIhe+7tXgdcjnm3KVGaL1eBIyU5qMwfMQqr6gXAVv9/ud",
  render_errors: [view: Pchat.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pchat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
