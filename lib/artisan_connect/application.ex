defmodule ArtisanConnect.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ArtisanConnectWeb.Telemetry,
      ArtisanConnect.Repo,
      {DNSCluster, query: Application.get_env(:artisan_connect, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ArtisanConnect.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ArtisanConnect.Finch},
      # Start a worker by calling: ArtisanConnect.Worker.start_link(arg)
      # {ArtisanConnect.Worker, arg},
      # Start to serve requests, typically the last entry
      ArtisanConnectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ArtisanConnect.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArtisanConnectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
