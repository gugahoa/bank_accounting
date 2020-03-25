defmodule BankAccountingWeb.AuthController do
  use BankAccountingWeb, :controller

  alias BankAccounting.{Auth, Ledger}

  action_fallback BankAccountingWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    with user <- Auth.get_user_by(email: email),
         {:ok, _user} <- Bcrypt.check_pass(user, password),
         {:ok, token, _claims} <- BankAccounting.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("login.json", access_token: token)
    else
      _ ->
        {:error, :invalid_credentials}
    end
  end

  def login(_conn, _params) do
    {:error, :missing_required_fields}
  end

  def signup(conn, params) do
    with {:ok, %{user: user, personal_account: personal_account}} <- Auth.signup(params) do
      conn
      |> put_status(:ok)
      |> render("signup.json",
        user: user,
        personal_account: Ledger.get_personal_account!(personal_account.id)
      )
    end
  end
end
