defmodule What2cook.Repo do
  use Ecto.Repo,
    otp_app: :what2cook,
    adapter: Ecto.Adapters.Postgres
end
