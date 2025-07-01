defmodule TravelAgency.Integrations.Actions do
  use Ash.Resource,
    domain: TravelAgency.Integrations,
    extensions: [AshAi]

  alias TravelAgency.Integrations.Reactors.TripReactor

  actions do
    action :book_trip, :struct do
      argument :user_email, :string, allow_nil?: false

      run TripReactor
    end

    action :compose_confirmation_email, :string do
      argument :flight_number, :string, allow_nil?: false
      argument :flight_confirmation_code, :string, allow_nil?: false
      argument :hotel_confirmation_code, :string, allow_nil?: false

      description """
      Composes a professional confirmation email for the user after booking a trip.
      Use basic HTML.
      """

      run prompt(LangChain.ChatModels.ChatAnthropic.new!(%{model: "claude-sonnet-4-0"}))
    end
  end
end
