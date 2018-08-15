# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sso,
  ecto_repos: [Sso.Repo]

# Configures the endpoint
config :sso, SsoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cOz5hii6P/mUYY+EH2fnOcWBGpICpLZo65cKvy47Z9ZcU83FWAZ4IdhZ21Qo6yEw",
  render_errors: [view: SsoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sso.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :sso, Sso.Auth.Guardian,
  issuer: "sso",
  secret_key: "aJZkfGUeC5+vrBj6agn3Bc393gwkaGqmkGcau4FNcNgcndKIfXqlMFYun2t8Crd5"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
