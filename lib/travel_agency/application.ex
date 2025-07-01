defmodule TravelAgency.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TravelAgencyWeb.Telemetry,
      TravelAgency.Repo,
      {DNSCluster, query: Application.get_env(:travel_agency, :dns_cluster_query) || :ignore},
      {Oban,
       AshOban.config(
         Application.fetch_env!(:travel_agency, :ash_domains),
         Application.fetch_env!(:travel_agency, Oban)
       )},
      {Phoenix.PubSub, name: TravelAgency.PubSub},
      # Start a worker by calling: TravelAgency.Worker.start_link(arg)
      # {TravelAgency.Worker, arg},
      # Start to serve requests, typically the last entry
      TravelAgencyWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :travel_agency]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TravelAgency.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TravelAgencyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
