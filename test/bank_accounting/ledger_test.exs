defmodule BankAccounting.LedgerTest do
  use BankAccounting.DataCase

  alias BankAccounting.Ledger

  describe "nominal_accounts" do
    alias BankAccounting.Ledger.NominalAccount

    @valid_attrs %{description: "some description"}
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
end