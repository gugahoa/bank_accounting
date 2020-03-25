defmodule BankAccounting.Ledger.PersonalAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "personal_accounts" do
    belongs_to :user, BankAccounting.Auth.User
    field :derived_balance, :decimal, default: 0

    timestamps()
  end

  @doc false
  def changeset(personal_account, attrs) do
    personal_account
    |> update_changeset(attrs)
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end

  @doc """
  update_changeset should be user everywhere, except for Personal Account
  creation. That's to ensure that we never change the user_id, as accounts
  don't change owners.
  """
  def update_changeset(personal_account, attrs) do
    personal_account
    |> cast(attrs, [])
    |> validate_required([])
  end
end
