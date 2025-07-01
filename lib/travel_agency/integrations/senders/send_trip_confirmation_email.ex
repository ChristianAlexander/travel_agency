defmodule TravelAgency.Integrations.Senders.SendTripConfirmationEmail do
  import Swoosh.Email

  alias TravelAgency.Mailer

  def send(email_address, body) do
    new()
    |> from({"noreply", "noreply@example.com"})
    |> to(email_address)
    |> subject("Your Trip Details!")
    |> html_body(body)
    |> Mailer.deliver()
  end
end
