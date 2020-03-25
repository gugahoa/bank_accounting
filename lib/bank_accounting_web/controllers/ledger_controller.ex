defmodule BankAccountingWeb.LedgerController do
  use BankAccountingWeb, :controller

  alias BankAccounting.Ledger

  def transfer(conn, %{"from" => from, "to" => to, "amount" => amount}) do
    user = Guardian.Plug.current_resource(conn)
    from = Ledger.get_personal_account!(from)
    to = Ledger.get_personal_account!(to)

    if user.id != from.user_id do
      conn
      |> put_status(:forbidden)
      |> put_view(BankAccountingWeb.ErrorView)
      |> render("error.json", message: "you're not authorized to perform this operation")
    else
      with {:ok, _} <- Ledger.transfer(from, to, amount) do
        conn
        |> put_status(:ok)
        |> render("transfer.json",
          from: Ledger.get_personal_account!(from.id),
          to: Ledger.get_personal_account!(to.id)
        )
      else
        {:error, _, %Ecto.Changeset{} = changeset, _} ->
          conn
          |> put_status(:bad_request)
          |> put_view(BankAccountingWeb.ErrorView)
          |> render("changeset.json", changeset: changeset)
      end
    end
  end
end
