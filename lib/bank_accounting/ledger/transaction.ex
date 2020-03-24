defmodule BankAccounting.Ledger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankAccounting.Ledger.{NominalAccount, PersonalAccount}

  schema "transactions" do
    field :value, :decimal
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
  end
end
