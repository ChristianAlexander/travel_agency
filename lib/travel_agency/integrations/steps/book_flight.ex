defmodule TravelAgency.Integrations.Steps.BookFlightStep do
  use Reactor.Step

  alias TravelAgency.Integrations.FlightService

  @impl Reactor.Step
  def run(%{flight_number: flight_number}, _context, _options) do
    FlightService.book(flight_number)
  end

  @impl Reactor.Step
  def undo(confirmation_code, _arguments, _context, _options) do
    FlightService.cancel(confirmation_code)
  end
end
