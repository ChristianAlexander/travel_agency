defmodule TravelAgency.Integrations do
  use Ash.Domain, extensions: [AshAi]

  tools do
    tool :book_trip, TravelAgency.Integrations.Actions, :book_trip
  end

  resources do
    resource TravelAgency.Integrations.Actions
  end
end
