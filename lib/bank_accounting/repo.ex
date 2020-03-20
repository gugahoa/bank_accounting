defmodule BankAccounting.Repo do
  use Ecto.Repo,
    otp_app: :bank_accounting,
    adapter: Ecto.Adapters.Postgres
end
