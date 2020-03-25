defmodule BankAccountingWeb.AuthController do
  use BankAccountingWeb, :controller

  alias BankAccounting.Auth

  def login(conn, %{"email" => email, "password" => password}) do
    with user <- Auth.get_user_by(email: email),
         {:ok, _user} <- Bcrypt.check_pass(user, password),
         {:ok, token, _claims} <- BankAccounting.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> json(%{"access_token" => token})
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{"error" => "invalid email/password combination"})
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{"error" => "missing required fields"})
  end
end
