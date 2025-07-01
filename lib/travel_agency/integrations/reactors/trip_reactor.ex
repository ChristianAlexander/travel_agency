defmodule TravelAgency.Integrations.Reactors.TripReactor do
  use Reactor, extensions: [Ash.Reactor]

  alias TravelAgency.Integrations.{EmailService, FlightService, HotelService}
  alias TravelAgency.Integrations.Steps.BookFlightStep

  input(:user_email)

  step :find_flight_number do
    run(fn _ -> FlightService.find_flight_number() end)
  end

  step :book_hotel do
    run fn _ -> HotelService.book() end
    undo fn confirmation -> HotelService.cancel(confirmation) end
  end

  step :book_flight, BookFlightStep do
    argument(:flight_number, result(:find_flight_number))
  end

  action :compose_email, TravelAgency.Integrations.Actions, :compose_confirmation_email do
    inputs %{
      flight_number: result(:find_flight_number),
      flight_confirmation_code: result(:book_flight),
      hotel_confirmation_code: result(:book_hotel)
    }
  end

  step :email_user do
    argument(:user_email, input(:user_email))
    argument(:email_message, result(:compose_email))
    max_retries(2)

    run(fn inputs ->
      EmailService.send(inputs.user_email, inputs.email_message)
    end)

    compensate(fn
      :bad_destination -> :ok
      :timeout -> :retry
    end)
  end

  collect :booking_results do
    argument(:hotel_code, result(:book_hotel))
    argument(:flight_number, result(:find_flight_number))
    argument(:flight_code, result(:book_flight))

    wait_for(:email_user)
  end

  return(:booking_results)
end
