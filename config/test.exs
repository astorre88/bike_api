use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bike_api, BikeApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bike_api, BikeApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bike_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bike_api, BikeApi.Guardian,
  issuer: "bike_api",
  secret_key: "BXv/fpg4Cs3Wa3JxsSa7oTjdoAF/qP3TMRkVC5GdqTsTt73umWu7ORMnIgdyAp1q"
