defmodule BankAccounting.LedgerTest do
  use BankAccounting.DataCase

  alias BankAccounting.Ledger

  describe "nominal_accounts" do
    alias BankAccounting.Ledger.NominalAccount

    @valid_attrs %{id: 100, description: "some description"}
    @update_attrs %{description: "some updated description"}
    @invalid_attrs %{description: nil}

    def nominal_account_fixture(attrs \\ %{}) do
      {:ok, nominal_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ledger.create_nominal_account()

      nominal_account
    end

    test "list_nominal_accounts/0 returns all nominal_accounts" do
      nominal_account = nominal_account_fixture()
      assert Ledger.list_nominal_accounts() == [nominal_account]
    end

    test "get_nominal_account!/1 returns the nominal_account with given id" do
      nominal_account = nominal_account_fixture()
      assert Ledger.get_nominal_account!(nominal_account.id) == nominal_account
    end

    test "create_nominal_account/1 with valid data creates a nominal_account" do
      assert {:ok, %NominalAccount{} = nominal_account} =
               Ledger.create_nominal_account(@valid_attrs)

      assert nominal_account.description == "some description"
    end

    test "create_nominal_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_nominal_account(@invalid_attrs)
    end

    test "update_nominal_account/2 with valid data updates the nominal_account" do
      nominal_account = nominal_account_fixture()

      assert {:ok, %NominalAccount{} = nominal_account} =
               Ledger.update_nominal_account(nominal_account, @update_attrs)

      assert nominal_account.description == "some updated description"
    end

    test "update_nominal_account/2 with invalid data returns error changeset" do
      nominal_account = nominal_account_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Ledger.update_nominal_account(nominal_account, @invalid_attrs)

      assert nominal_account == Ledger.get_nominal_account!(nominal_account.id)
    end

    test "delete_nominal_account/1 deletes the nominal_account" do
      nominal_account = nominal_account_fixture()
      assert {:ok, %NominalAccount{}} = Ledger.delete_nominal_account(nominal_account)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_nominal_account!(nominal_account.id) end
    end

    test "change_nominal_account/1 returns a nominal_account changeset" do
      nominal_account = nominal_account_fixture()
      assert %Ecto.Changeset{} = Ledger.change_nominal_account(nominal_account)
    end
  end

  describe "personal_accounts" do
    alias BankAccounting.Ledger.PersonalAccount

    test "list_personal_accounts/0 returns all personal_accounts" do
      personal_account = insert(:personal_account)

      assert Ledger.list_personal_accounts() |> Enum.map(&BankAccounting.Repo.preload(&1, :user)) ==
               [personal_account]
    end

    test "get_personal_account!/1 returns the personal_account with given id" do
      personal_account = insert(:personal_account)

      assert Ledger.get_personal_account!(personal_account.id)
             |> BankAccounting.Repo.preload(:user) == personal_account
    end

    test "create_personal_account/1 with valid data creates a personal_account" do
      user = insert(:user)

      assert {:ok, %PersonalAccount{} = personal_account} =
               Ledger.create_personal_account(%{user_id: user.id})
    end

    test "create_personal_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_personal_account(%{})
    end

    test "delete_personal_account/1 deletes the personal_account" do
      personal_account = insert(:personal_account)
      assert {:ok, %PersonalAccount{}} = Ledger.delete_personal_account(personal_account)

      assert_raise Ecto.NoResultsError, fn ->
        Ledger.get_personal_account!(personal_account.id)
      end
    end

    test "change_personal_account/1 returns a personal_account changeset" do
      personal_account = insert(:personal_account)
      assert %Ecto.Changeset{} = Ledger.change_personal_account(personal_account)
    end
  end

  describe "transaction_types" do
    alias BankAccounting.Ledger.TransactionType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def transaction_type_fixture(attrs \\ %{}) do
      {:ok, transaction_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ledger.create_transaction_type()

      transaction_type
    end

    test "list_transaction_types/0 returns all transaction_types" do
      transaction_type = transaction_type_fixture()
      assert Ledger.list_transaction_types() == [transaction_type]
    end

    test "get_transaction_type!/1 returns the transaction_type with given id" do
      transaction_type = transaction_type_fixture()
      assert Ledger.get_transaction_type!(transaction_type.name) == transaction_type
    end

    test "create_transaction_type/1 with valid data creates a transaction_type" do
      assert {:ok, %TransactionType{} = transaction_type} =
               Ledger.create_transaction_type(@valid_attrs)

      assert transaction_type.name == "some name"
    end

    test "create_transaction_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_transaction_type(@invalid_attrs)
    end

    test "update_transaction_type/2 with valid data updates the transaction_type" do
      transaction_type = transaction_type_fixture()

      assert {:ok, %TransactionType{} = transaction_type} =
               Ledger.update_transaction_type(transaction_type, @update_attrs)

      assert transaction_type.name == "some updated name"
    end

    test "update_transaction_type/2 with invalid data returns error changeset" do
      transaction_type = transaction_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Ledger.update_transaction_type(transaction_type, @invalid_attrs)

      assert transaction_type == Ledger.get_transaction_type!(transaction_type.name)
    end

    test "delete_transaction_type/1 deletes the transaction_type" do
      transaction_type = transaction_type_fixture()
      assert {:ok, %TransactionType{}} = Ledger.delete_transaction_type(transaction_type)

      assert_raise Ecto.NoResultsError, fn ->
        Ledger.get_transaction_type!(transaction_type.name)
      end
    end

    test "change_transaction_type/1 returns a transaction_type changeset" do
      transaction_type = transaction_type_fixture()
      assert %Ecto.Changeset{} = Ledger.change_transaction_type(transaction_type)
    end
  end

  describe "transactions" do
    alias Ledger.Transaction

    test "deposit/2 with valid data should properly create a transaction" do
      personal_account = insert(:personal_account)
      insert(:nominal_account)
      insert(:debit_type)

      value = Decimal.new("100.0")

      assert {:ok, %Transaction{value: ^value, type: "debit"}} =
               Ledger.deposit(personal_account, value)
    end

    test "deposit/2 with negative value should not create a transaction" do
      personal_account = insert(:personal_account)
      insert(:nominal_account)
      insert(:debit_type)

      assert {:error, %Ecto.Changeset{}} = Ledger.deposit(personal_account, "-100.0")
    end

    test "deposit/2 with invalid value should not create a transaction" do
      personal_account = insert(:personal_account)
      insert(:nominal_account)
      insert(:debit_type)

      assert_raise Decimal.Error, fn -> Ledger.deposit(personal_account, "somestring") end
    end

    test "deposit/2 should allow float and integer as amount argument" do
      personal_account = insert(:personal_account)
      insert(:nominal_account)
      insert(:debit_type)

      value = Decimal.from_float(100.0)

      assert {:ok, %Transaction{value: ^value, type: "debit"}} =
               Ledger.deposit(personal_account, 100.0)

      value = Decimal.new(100)

      assert {:ok, %Transaction{value: ^value, type: "debit"}} =
               Ledger.deposit(personal_account, 100)
    end

    test "balance/1 should return the account balance" do
      insert(:debit_type)
      personal_account = insert(:personal_account)
      assert Decimal.eq?(Ledger.balance(personal_account), Decimal.new(0))

      insert(:deposit, %{value: 50, personal_account: personal_account})
      assert Decimal.eq?(Ledger.balance(personal_account), Decimal.new(50))
    end

    test "transfer/3 should transfer money from one account to another" do
      insert(:debit_type)
      from = insert(:personal_account)
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))

      insert(:deposit, %{value: 50, personal_account: from})
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(50))

      insert(:credit_type)
      to = insert(:personal_account)
      assert {:ok, %{}} = Ledger.transfer(from, to, 50)
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))
      assert Decimal.eq?(Ledger.balance(to), Decimal.new(50))
    end

    test "transfer/3 from an account without funds should return an error" do
      insert(:debit_type)
      insert(:nominal_account)
      from = insert(:personal_account)
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))

      insert(:credit_type)
      to = insert(:personal_account)

      assert {:error, :from_transaction, %Ecto.Changeset{}, _changes_so_far} =
               Ledger.transfer(from, to, 50)

      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))
      assert Decimal.eq?(Ledger.balance(to), Decimal.new(0))
    end

    test "transfer/3 with a negative amount as argument should not be possible" do
      insert(:nominal_account)
      from = insert(:personal_account)
      to = insert(:personal_account)
      assert {:error, :from_transaction, %Ecto.Changeset{}, _} = Ledger.transfer(from, to, -5)
    end

    test "transfer/3 should allow float and string as amount argument" do
      insert(:debit_type)
      from = insert(:personal_account)
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))

      insert(:deposit, %{value: 50, personal_account: from})
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(50))

      insert(:credit_type)
      to = insert(:personal_account)
      assert {:ok, %{}} = Ledger.transfer(from, to, 10.0)
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(40))
      assert Decimal.eq?(Ledger.balance(to), Decimal.new(10))

      assert {:ok, %{}} = Ledger.transfer(from, to, "40.0")
      assert Decimal.eq?(Ledger.balance(from), Decimal.new(0))
      assert Decimal.eq?(Ledger.balance(to), Decimal.new(50))
    end
  end
end
