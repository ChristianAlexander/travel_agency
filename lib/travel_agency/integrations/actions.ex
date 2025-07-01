defmodule TravelAgency.Integrations.Actions do
  use Ash.Resource, domain: TravelAgency.Integrations

  alias TravelAgency.Integrations.Reactors.TripReactor

  actions do
    action :book_trip, :struct do
      argument :user_email, :string, allow_nil?: false

      run TripReactor
    end
  end
end
