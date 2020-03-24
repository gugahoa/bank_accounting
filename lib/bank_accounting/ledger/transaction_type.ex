defmodule BankAccounting.Ledger.TransactionType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:name, :string, autogenerate: false}
  schema "transaction_types" do
    timestamps()
  end

  @doc false
  def changeset(transaction_type, attrs) do
    transaction_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
