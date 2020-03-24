defmodule BankAccounting.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :string, null: false
      add :personal_account_id, references(:personal_accounts, on_delete: :nothing), null: false
      add :nominal_account_id, references(:nominal_accounts, on_delete: :nothing), null: false
      add :type, references(:transaction_types, column: :name, type: :string, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transactions, [:personal_account_id])
    create index(:transactions, [:nominal_account_id])
    create index(:transactions, [:type])
    create index(:transactions, [:inserted_at])
  end
end
