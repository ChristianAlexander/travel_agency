defmodule TravelAgency.Integrations.HotelService do
  require Logger

  @failure_rate 0.2

  def book() do
    Logger.info("Booking hotel")

    if :rand.uniform() < @failure_rate do
      Logger.error("[#{__MODULE__}] failed to reserve hotel room")
      {:error, "Failed to reserve room"}
    else
      {:ok, confirmation_code()}
    end
  end

  def cancel(code) do
    Logger.warning("[#{__MODULE__}] canceling hotel reservation #{code}")
    :ok
  end

  defp confirmation_code() do
    "HOTEL-#{Nanoid.generate()}"
  end
end
