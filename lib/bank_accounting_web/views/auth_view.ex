defmodule BankAccountingWeb.AuthView do
  use BankAccountingWeb, :view

  def render("login.json", %{access_token: access_token}) do
    %{
      access_token: access_token
    }
  end

  def render("signup.json", %{user: user, personal_account: personal_account}) do
    %{
      user: %{
        email: user.email
      },
      personal_account: %{
        id: personal_account.id,
        balance: personal_account.derived_balance
      }
    }
  end
end
