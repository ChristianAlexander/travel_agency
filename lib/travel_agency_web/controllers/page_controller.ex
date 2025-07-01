defmodule TravelAgencyWeb.PageController do
  use TravelAgencyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
