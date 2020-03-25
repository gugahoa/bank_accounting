defmodule BankAccountingWeb.Router do
  use BankAccountingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankAccountingWeb do
    pipe_through :api

    post "/login", AuthController, :login
    post "/signup", AuthController, :signup
  end
end
