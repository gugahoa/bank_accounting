defmodule BankAccountingWeb.AuthView do
  use BankAccountingWeb, :view

  def render("login.json", %{access_token: access_token}) do
    %{
      access_token: access_token
    }
  end
end
