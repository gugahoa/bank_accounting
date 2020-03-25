defmodule BankAccounting.Ledger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankAccounting.Ledger.{NominalAccount, PersonalAccount}

  schema "transactions" do
    field :value, :decimal
    # The type here is from the point of view of a Nominal Account
    # So a type of "debit" means we're doing a debit on the Nominal Account
    # and a credit on the Personal Account
    field :type, :string

    belongs_to :nominal_account, NominalAccount
    belongs_to :personal_account, PersonalAccount

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :personal_account_id, :nominal_account_id, :type])
    |> validate_required([:value, :personal_account_id, :nominal_account_id, :type])
    |> check_constraint(:value, name: :derived_balance_must_be_positive, message: "is bigger than what is available for the personal account")
  end
end
