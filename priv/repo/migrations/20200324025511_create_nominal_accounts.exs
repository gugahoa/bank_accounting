defmodule BankAccounting.Repo.Migrations.CreateNominalAccounts do
  use Ecto.Migration

  def change do
    create table(:nominal_accounts) do
      add :description, :string

      timestamps()
    end
  end
end
