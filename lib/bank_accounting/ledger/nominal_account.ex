defmodule BankAccounting.Ledger.NominalAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nominal_accounts" do
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(nominal_account, attrs) do
    nominal_account
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
