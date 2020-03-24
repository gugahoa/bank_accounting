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
end
