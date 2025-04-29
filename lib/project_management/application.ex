defmodule ProjectManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjectManagementWeb.Telemetry,
      ProjectManagement.Repo,
      {DNSCluster,
       query: Application.get_env(:project_management, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjectManagement.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProjectManagement.Finch},
      # Start a worker by calling: ProjectManagement.Worker.start_link(arg)
      # {ProjectManagement.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjectManagementWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectManagement.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
