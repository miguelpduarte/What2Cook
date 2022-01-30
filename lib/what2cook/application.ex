defmodule What2cook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      What2cook.Repo,
      # Start the Telemetry supervisor
      What2cookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: What2cook.PubSub},
      # Start the Endpoint (http/https)
      What2cookWeb.Endpoint
      # Start a worker by calling: What2cook.Worker.start_link(arg)
      # {What2cook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: What2cook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    What2cookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
