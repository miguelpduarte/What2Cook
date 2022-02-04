defmodule What2Cook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      What2Cook.Repo,
      # Start the Telemetry supervisor
      What2CookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: What2Cook.PubSub},
      # Start the Endpoint (http/https)
      What2CookWeb.Endpoint
      # Start a worker by calling: What2Cook.Worker.start_link(arg)
      # {What2Cook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: What2Cook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    What2CookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
