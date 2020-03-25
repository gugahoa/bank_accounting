defmodule BankAccountingWeb.LedgerView do
  use BankAccountingWeb, :view

  def render("transfer.json", %{from: from}) do
    %{
      success: true,
      from: render_one(from, BankAccountingWeb.LedgerView, "balance.json", as: :personal_account)
    }
  end

  def render("balance.json", %{personal_account: personal_account}) do
    %{
      id: personal_account.id,
      balance: personal_account.derived_balance
    }
  end
end
