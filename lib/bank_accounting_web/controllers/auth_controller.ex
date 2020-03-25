defmodule BankAccountingWeb.AuthController do
  use BankAccountingWeb, :controller

  alias BankAccounting.{Auth, Ledger}

  def login(conn, %{"email" => email, "password" => password}) do
    with user <- Auth.get_user_by(email: email),
         {:ok, _user} <- Bcrypt.check_pass(user, password),
         {:ok, token, _claims} <- BankAccounting.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("login.json", access_token: token)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> put_view(BankAccountingWeb.ErrorView)
        |> render("error.json", message: "invalid email/password combination")
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankAccountingWeb.ErrorView)
    |> render("error.json", message: "missing required fields")
  end

  def signup(conn, params) do
    with {:ok, %{user: user, personal_account: personal_account}} <- Auth.signup(params) do
      conn
      |> put_status(:ok)
      |> render("signup.json",
        user: user,
        personal_account: Ledger.get_personal_account!(personal_account.id)
      )
    else
      {:error, _, %Ecto.Changeset{} = changeset, _} ->
        conn
        |> put_status(:bad_request)
        |> put_view(BankAccountingWeb.ErrorView)
        |> render("changeset.json", changeset: changeset)
    end
  end
end
