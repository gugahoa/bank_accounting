defmodule BankAccounting.AuthControllerTest do
  use BankAccountingWeb.ConnCase

  describe "login/2" do
    test "Authenticates user and return with a valid access token", %{conn: conn} do
      user =
        build(:user)
        |> set_user_password("pass")
        |> insert

      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{ "email" => user.email, "password" => "pass"}
        )
        |> json_response(:ok)

      assert %{"access_token" => token} = response
      assert {:ok, user} = BankAccounting.Guardian.decode_and_verify(token)
    end

    test "Returns an error if the credentials don't match", %{conn: conn} do
      user =
        build(:user)
        |> set_user_password("pass")
        |> insert

      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{ "email" => user.email, "password" => "wrong pass"}
        )
        |> json_response(:bad_request)

      assert %{"error" => _} = response
    end

    test "Returns an error if user doesn't exist", %{conn: conn} do
      response =
        conn
        |> post(
          Routes.auth_path(conn, :login),
          %{ "email" => "some email", "password" => "pass"}
        )
        |> json_response(:bad_request)

      assert %{"error" => _} = response
    end
  end
end
