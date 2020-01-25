# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :milbase,
  ecto_repos: [Milbase.Repo]

# Configures the endpoint
config :milbase, MilbaseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tr+xnd0qSY2TgnHbL1+7LSPxdh7UgBSw+VK5iqLlwm2LpddWnJw1Me9cu8DaeAUg",
  render_errors: [view: MilbaseWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Milbase.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :milbase, MilbaseWeb.Gettext, default_locale: "id_ID", locales: ~w(en id_ID)

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
config :milbase, Milbase.Guardian,
       issuer: "milbase",
       secret_key: "4jIl9bOnQnpM3TA1J1RyQJlfUYpi+C0bVbFDyyXJn7VuxawT68WycaBY7jwx1u/b"


