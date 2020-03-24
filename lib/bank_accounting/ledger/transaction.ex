defmodule BankAccounting.Ledger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :value, :string
    field :personal_account_id, :id
    field :nominal_account_id, :id
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :personal_account_id, :nominal_account_id, :type])
    |> validate_required([:value, :personal_account_id, :nominal_account_id, :type])
  end
end
