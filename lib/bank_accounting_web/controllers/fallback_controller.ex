defmodule BankAccountingWeb.FallbackController do
  use BankAccountingWeb, :controller

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(BankAccountingWeb.ErrorView)
    |> render("error.json", message: "you're not authorized to perform this operation")
  end

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankAccountingWeb.ErrorView)
    |> render("error.json", message: "invalid email/password combination")
  end

  def call(conn, {:error, :missing_required_fields}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankAccountingWeb.ErrorView)
    |> render("error.json", message: "missing required fields")
  end

  def call(conn, {:error, _, %Ecto.Changeset{} = changeset, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankAccountingWeb.ErrorView)
    |> render("changeset.json", changeset: changeset)
  end
end
