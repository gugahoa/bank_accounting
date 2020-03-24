defmodule BankAccounting.Factory do
  use ExMachina.Ecto, repo: BankAccounting.Repo

  def user_factory do
    %BankAccounting.Auth.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: nil
    }
  end

  def set_user_password(user, password) do
    user
    |> BankAccounting.Auth.User.changeset(%{"password" => password})
    |> Ecto.Changeset.apply_changes()

    user
  end

  def personal_account_factory do
    %BankAccounting.Ledger.PersonalAccount{
      user: build(:user),
    }
  end

  def nominal_account_factory do
    %BankAccounting.Ledger.NominalAccount{
      id: 100
    }
  end

  def credit_type_factory do
    %BankAccounting.Ledger.TransactionType{
      name: "credit"
    }
  end

  def debit_type_factory do
    %BankAccounting.Ledger.TransactionType{
      name: "debit"
    }
  end
end
