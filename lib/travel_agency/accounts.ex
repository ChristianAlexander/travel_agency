defmodule TravelAgency.Accounts do
  use Ash.Domain,
    otp_app: :travel_agency

  resources do
    resource TravelAgency.Accounts.Token
    resource TravelAgency.Accounts.User
  end
end
