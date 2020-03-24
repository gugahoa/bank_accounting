defmodule BankAccounting.Ledger do
  @moduledoc """
  The Ledger context.
  """

  import Ecto.Query, warn: false
  alias BankAccounting.Repo

  alias BankAccounting.Ledger.NominalAccount

  @doc """
  Returns the list of nominal_accounts.

  ## Examples

      iex> list_nominal_accounts()
      [%NominalAccount{}, ...]

  """
  def list_nominal_accounts do
    Repo.all(NominalAccount)
  end

  @doc """
  Gets a single nominal_account.

  Raises `Ecto.NoResultsError` if the Nominal account does not exist.

  ## Examples

      iex> get_nominal_account!(123)
      %NominalAccount{}

      iex> get_nominal_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nominal_account!(id), do: Repo.get!(NominalAccount, id)

  @doc """
  Creates a nominal_account.

  ## Examples

      iex> create_nominal_account(%{field: value})
      {:ok, %NominalAccount{}}

      iex> create_nominal_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nominal_account(attrs \\ %{}) do
    %NominalAccount{}
    |> NominalAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nominal_account.

  ## Examples

      iex> update_nominal_account(nominal_account, %{field: new_value})
      {:ok, %NominalAccount{}}

      iex> update_nominal_account(nominal_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nominal_account(%NominalAccount{} = nominal_account, attrs) do
    nominal_account
    |> NominalAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nominal_account.

  ## Examples

      iex> delete_nominal_account(nominal_account)
      {:ok, %NominalAccount{}}

      iex> delete_nominal_account(nominal_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nominal_account(%NominalAccount{} = nominal_account) do
    Repo.delete(nominal_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nominal_account changes.

  ## Examples

      iex> change_nominal_account(nominal_account)
      %Ecto.Changeset{source: %NominalAccount{}}

  """
  def change_nominal_account(%NominalAccount{} = nominal_account) do
    NominalAccount.changeset(nominal_account, %{})
  end
end
