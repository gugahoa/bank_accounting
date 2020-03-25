defmodule BankAccountingWeb.LedgerView do
  use BankAccountingWeb, :view

  def render("transfer.json", %{from: from, to: to}) do
    %{
      from: %{
        id: from.id,
        balance: from.derived_balance
      },
      to: %{
        id: to.id,
        balance: to.derived_balance
      }
    }
  end
end
