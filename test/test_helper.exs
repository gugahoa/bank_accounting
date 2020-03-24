Application.ensure_started(:ex_machina)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BankAccounting.Repo, :manual)
