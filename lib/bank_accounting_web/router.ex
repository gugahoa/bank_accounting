defmodule BankAccountingWeb.Router do
  use BankAccountingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Guardian.Plug.Pipeline,
      module: BankAccounting.Guardian,
      error_handler: BankAccounting.GuardianErrorHandler

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
    get "/balance/:account_id", LedgerController, :balance
  end
end
