defmodule BankAccounting.Repo.Migrations.AddDerivedBalanceToPersonalAccounts do
  use Ecto.Migration

  def up do
    alter table(:personal_accounts) do
      add :derived_balance, :numeric, null: false, default: 0
    end

    create constraint(:personal_accounts, :derived_balance_must_be_positive,
             check: "derived_balance >= 0"
           )

    execute """
    CREATE FUNCTION update_derived_balance()
    RETURNS trigger
    AS $$
      BEGIN
        IF (NEW.type = 'debit') THEN
          UPDATE personal_accounts 
          SET derived_balance = derived_balance + NEW.value
          WHERE id = NEW.personal_account_id;
        ELSIF (NEW.type = 'credit') THEN
          UPDATE personal_accounts 
          SET derived_balance = derived_balance - NEW.value
          WHERE id = NEW.personal_account_id;
        END IF;

        RETURN NULL;
      END;
    $$
    LANGUAGE plpgsql;
    """

    execute """
    CREATE TRIGGER update_derived_balance_trigger
    AFTER INSERT ON transactions
    FOR EACH ROW
    EXECUTE FUNCTION update_derived_balance();
    """
  end

  def down do
    drop(constraint(:personal_accounts, :derived_balance_must_be_positive))

    alter table(:personal_accounts) do
      remove :derived_balance
    end

    execute "DROP TRIGGER update_derived_balance_trigger"
    execute "DROP FUNCTION update_derived_balance"
  end
end
