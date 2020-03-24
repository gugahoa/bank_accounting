defmodule BankAccounting.Repo.Migrations.CreatePersonalAccounts do
  use Ecto.Migration

  def change do
    create table(:personal_accounts) do
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:personal_accounts, [:user_id])
  end
end
