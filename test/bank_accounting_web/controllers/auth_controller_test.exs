defmodule BankAccounting.AuthControllerTest do
  use BankAccountingWeb.ConnCase

  describe "login/2" do
    test "Authenticates user and return with a valid access token", %{conn: conn} do
      user =
        build(:user)
        |> set_user_password("pass")
        |> insert

      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{"email" => user.email, "password" => "pass"}
        )
        |> json_response(:ok)

      assert %{"access_token" => token} = response
      assert {:ok, user} = BankAccounting.Guardian.decode_and_verify(token)
    end

    test "Returns an error if the credentials don't match", %{conn: conn} do
      user =
        build(:user)
        |> set_user_password("pass")
        |> insert

      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{"email" => user.email, "password" => "wrong pass"}
        )
        |> json_response(:bad_request)

      assert %{"error" => _} = response
    end

    test "Returns an error if user doesn't exist", %{conn: conn} do
      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{"email" => "some email", "password" => "pass"}
        )
        |> json_response(:bad_request)

      assert %{"error" => _} = response
    end
  end

  describe "signup/2" do
    test "create a new user and personal account", %{conn: conn} do
      response =
        conn
        |> post(
          Routes.auth_path(conn, :signup),
          %{"email" => "example", "password" => "password"}
        )
        |> json_response(:ok)

      assert %{
               "user" => %{"email" => "example"},
               "personal_account" => %{"id" => account_id, "balance" => "0"}
             } = response

      assert %BankAccounting.Ledger.PersonalAccount{} =
               BankAccounting.Ledger.get_personal_account!(account_id)

      assert %BankAccounting.Auth.User{} = BankAccounting.Auth.get_user_by(email: "example")
    end

    test "create a new user and personal account with a initial deposit", %{conn: conn} do
      insert(:nominal_account)
      insert(:debit_type)

      response =
        conn
        |> post(
          Routes.auth_path(conn, :signup),
          %{"email" => "example", "password" => "password", "initial_deposit" => 500}
        )
        |> json_response(:ok)

      assert %{
               "user" => %{"email" => "example"},
               "personal_account" => %{"id" => account_id, "balance" => "500"}
             } = response

      assert %BankAccounting.Ledger.PersonalAccount{} =
               personal_account = BankAccounting.Ledger.get_personal_account!(account_id)

      assert Decimal.eq?(personal_account.derived_balance, Decimal.new(500))

      assert %BankAccounting.Auth.User{} = BankAccounting.Auth.get_user_by(email: "example")
    end

    test "returns an error when required parameters are missing", %{conn: conn} do
      response =
        conn
        |> post(
          Routes.auth_path(conn, :signup),
          %{}
        )
        |> json_response(:bad_request)

      assert %{"error" => _error} = response
    end
  end
end
