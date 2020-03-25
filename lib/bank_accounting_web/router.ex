defmodule BankAccountingWeb.Router do
  use BankAccountingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do 
    plug Guardian.Plug.Pipeline, module: BankAccounting.Guardian

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api", BankAccountingWeb do
    pipe_through :api

    post "/login", AuthController, :login
    post "/signup", AuthController, :signup
  end

  scope "/api", BankAccountingWeb do
    pipe_through [:api, :protected]

    post "/transfer/:from/:to", LedgerController, :transfer
  end
end
