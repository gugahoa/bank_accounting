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

  alias BankAccounting.Ledger.PersonalAccount

  @doc """
  Returns the list of personal_accounts.

  ## Examples

      iex> list_personal_accounts()
      [%PersonalAccount{}, ...]

  """
  def list_personal_accounts do
    Repo.all(PersonalAccount)
  end

  @doc """
  Gets a single personal_account.

  Raises `Ecto.NoResultsError` if the Personal account does not exist.

  ## Examples

      iex> get_personal_account!(123)
      %PersonalAccount{}

      iex> get_personal_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_personal_account!(id), do: Repo.get!(PersonalAccount, id)

  @doc """
  Creates a personal_account.

  ## Examples

      iex> create_personal_account(%{field: value})
      {:ok, %PersonalAccount{}}

      iex> create_personal_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_personal_account(attrs \\ %{}) do
    %PersonalAccount{}
    |> PersonalAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a personal_account.

  ## Examples

      iex> update_personal_account(personal_account, %{field: new_value})
      {:ok, %PersonalAccount{}}

      iex> update_personal_account(personal_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_personal_account(%PersonalAccount{} = personal_account, attrs) do
    personal_account
    |> PersonalAccount.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a personal_account.

  ## Examples

      iex> delete_personal_account(personal_account)
      {:ok, %PersonalAccount{}}

      iex> delete_personal_account(personal_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_personal_account(%PersonalAccount{} = personal_account) do
    Repo.delete(personal_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking personal_account changes.

  ## Examples

      iex> change_personal_account(personal_account)
      %Ecto.Changeset{source: %PersonalAccount{}}

  """
  def change_personal_account(%PersonalAccount{} = personal_account) do
    PersonalAccount.update_changeset(personal_account, %{})
  end
end
