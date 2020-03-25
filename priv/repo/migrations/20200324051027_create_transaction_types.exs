defmodule BankAccounting.Repo.Migrations.CreateTransactionTypes do
  use Ecto.Migration

  def change do
    create table(:transaction_types, primary_key: false) do
      add :name, :string, primary_key: true

      timestamps()
    end
  end
end
