defmodule ExampleOauth.Repo do
  use Ecto.Repo,
    otp_app: :example_oauth,
    adapter: Ecto.Adapters.Postgres
end
