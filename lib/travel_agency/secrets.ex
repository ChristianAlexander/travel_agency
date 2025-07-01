defmodule TravelAgency.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        TravelAgency.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:travel_agency, :token_signing_secret)
  end
end
