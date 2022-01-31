import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :what2cook, What2cook.Repo,
  username: "postgres",
  password: "pg!what2cook_local",
  hostname: "localhost",
  database: "what2cook_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :what2cook, What2cookWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "fdtAOz3124/Q4yHTsiNrklYMWbHpvPFmjB4iHnLc6eLqXNFPPaEqPczT+/k8POgM",
  server: false

# In test we don't send emails.
config :what2cook, What2cook.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
