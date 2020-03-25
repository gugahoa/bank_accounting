# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BankAccounting.Repo.insert!(%BankAccounting.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BankAccounting.Ledger

Ledger.create_nominal_account(%{
  id: 100,
  description: "Bank Cash Asset"
})

Ledger.create_transaction_type(%{name: "debit"})
Ledger.create_transaction_type(%{name: "credit"})
