defmodule BankAccounting.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias BankAccounting.Repo

  alias BankAccounting.Auth.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by parameter.

  ## Examples

      iex> get_user_by!(email: email)
      %User{}

      iex> get_user_by!(email: email)
      nil

  """
  def get_user_by(opts), do: Repo.get_by(User, opts)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias BankAccounting.Ledger
  alias Ecto.Multi

  @doc """
  Returns a user and personal account with the specified initial deposit

  ## Examples

      iex> signup(params)
      {:ok, %{ user: %User{}, personal_account: %PersonalAccount{}}}

      iex> signup(params)
      {:error, :user, %Ecto.Changeset{}, %{}}

      iex> signup(params)
      {:error, :personal_account, %Ecto.Changeset{}, %{}}
  """
  def signup(params) do
    multi =
      Multi.new()
      |> Multi.insert(:user, User.changeset(%User{}, params))
      |> Multi.run(:personal_account, fn _repo, %{user: user} ->
        with {:ok, personal_account} = ret <- Ledger.create_personal_account(%{user_id: user.id}) do
          initial_deposit =
            Map.get(params, "initial_deposit") || Map.get(params, :initial_deposit)

          if initial_deposit != nil and initial_deposit > 0 do
            Ledger.deposit(personal_account, initial_deposit)
          end

          ret
        end
      end)

    Repo.transaction(multi)
  end
end
