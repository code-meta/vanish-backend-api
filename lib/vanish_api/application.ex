defmodule VanishApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VanishApiWeb.Telemetry,
      VanishApi.Repo,
      {DNSCluster, query: Application.get_env(:vanish_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VanishApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VanishApi.Finch},
      # Start a worker by calling: VanishApi.Worker.start_link(arg)
      # {VanishApi.Worker, arg},
      # Start to serve requests, typically the last entry
      VanishApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VanishApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VanishApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
