defmodule BankAccountingWeb.LedgerControllerTest do
  use BankAccountingWeb.ConnCase

  alias BankAccounting.Ledger

  describe "transfer/2" do
    test "should transfer funds from one account to another", %{conn: conn} do
      insert(:debit_type)
      insert(:credit_type)

      user = insert(:user)
      personal_account = insert(:personal_account, %{user: user})
      insert(:deposit, %{personal_account: personal_account, value: 500})

      another_personal_account = insert(:personal_account)

      {:ok, token, _} = BankAccounting.Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> post(
          Routes.ledger_path(conn, :transfer, personal_account.id, another_personal_account.id),
          %{amount: 50}
        )
        |> json_response(:ok)

      personal_account_id = personal_account.id

      assert %{
               "from" => %{"balance" => "450", "id" => ^personal_account_id},
               "success" => true
             } = response

      assert Decimal.eq?(Ledger.balance(another_personal_account), Decimal.new(50))

      assert Decimal.eq?(Ledger.balance(personal_account), Decimal.new(450))
    end

    test "should return an error if account is not from user", %{conn: conn} do
      user = insert(:user)
      personal_account = insert(:personal_account)
      another_personal_account = insert(:personal_account)

      {:ok, token, _} = BankAccounting.Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> post(
          Routes.ledger_path(conn, :transfer, personal_account.id, another_personal_account.id),
          %{amount: 50}
        )
        |> json_response(:forbidden)

      assert %{"error" => _error} = response
    end

    test "should return an error if account doesn't have enough funds", %{conn: conn} do
      insert(:nominal_account)
      insert(:debit_type)
      insert(:credit_type)

      user = insert(:user)
      personal_account = insert(:personal_account, %{user: user})

      another_personal_account = insert(:personal_account)

      {:ok, token, _} = BankAccounting.Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> post(
          Routes.ledger_path(conn, :transfer, personal_account.id, another_personal_account.id),
          %{amount: 50}
        )
        |> json_response(:bad_request)

      assert %{"error" => _error} = response

      assert Decimal.eq?(Ledger.balance(another_personal_account), Decimal.new(0))

      assert Decimal.eq?(Ledger.balance(personal_account), Decimal.new(0))
    end
  end

  describe "balance/2" do
    test "should show current account balance", %{conn: conn} do
      insert(:debit_type)
      insert(:credit_type)

      user = insert(:user)
      personal_account = insert(:personal_account, %{user: user})
      insert(:deposit, %{personal_account: personal_account, value: 500})

      {:ok, token, _} = BankAccounting.Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> get(Routes.ledger_path(conn, :balance, personal_account.id))
        |> json_response(:ok)

      personal_account_id = personal_account.id

      assert %{
               "balance" => "500",
               "id" => ^personal_account_id
             } = response

      assert Decimal.eq?(Ledger.balance(personal_account), Decimal.new(500))
    end

    test "should return an error if account is not from user", %{conn: conn} do
      user = insert(:user)
      personal_account = insert(:personal_account)

      {:ok, token, _} = BankAccounting.Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "bearer #{token}")
        |> get(Routes.ledger_path(conn, :balance, personal_account.id))
        |> json_response(:forbidden)

      assert %{"error" => _error} = response
    end
  end
end
