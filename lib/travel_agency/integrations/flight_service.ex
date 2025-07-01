defmodule TravelAgency.Integrations.FlightService do
  require Logger

  @failure_rate 0.05

  def find_flight_number() do
    Logger.info("Finding flight")

    if :rand.uniform() < @failure_rate do
      Logger.error("[#{__MODULE__}] failed to reserve flight")
      {:error, "Failed to reserve flight"}
    else
      {:ok, "CS-2025"}
    end
  end

  def book(flight_number) do
    Logger.info("Booking flight, #{flight_number}")

    if :rand.uniform() < @failure_rate do
      Logger.error("[#{__MODULE__}] failed to reserve flight")
      {:error, "Failed to reserve flight"}
    else
      {:ok, confirmation_code()}
    end
  end

  def cancel(code) do
    Logger.warning("[#{__MODULE__}] canceling flight reservation #{code}")
    :ok
  end

  defp confirmation_code() do
    "FLY-#{Nanoid.generate()}"
  end
end
