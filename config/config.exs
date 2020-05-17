# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :example_oauth,
  ecto_repos: [ExampleOauth.Repo]

# Configures the endpoint
config :example_oauth, ExampleOauthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "R07h7Z+yisXFC/FeCQ1crVinyneYkYu7alGQEhkhr47gX7b5I5/j9/JMy00Uf7WW",
  render_errors: [view: ExampleOauthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ExampleOauth.PubSub,
  live_view: [signing_salt: "YTJZk5BZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
  providers: [
    discord: {Ueberauth.Strategy.Discord, [
      default_scope: "identify email connections guilds"
    ]}
  ]

