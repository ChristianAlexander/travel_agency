defmodule TravelAgency.Integrations.EmailService do
  require Logger

  alias TravelAgency.Integrations.Senders.SendTripConfirmationEmail

  @timeout_rate 0.5

  def send(destination, message) do
    Logger.info("Sending email to #{destination}: #{message}")

    cond do
      :rand.uniform() < @timeout_rate ->
        :timer.sleep(1_000)

        Logger.warning("[#{__MODULE__}] timeout")
        {:error, :timeout}

      String.contains?(destination, "example.net") ->
        Logger.error("[#{__MODULE__}] bad destination address")
        {:error, :bad_destination}

      true ->
        SendTripConfirmationEmail.send(destination, message)
    end
  end
end
