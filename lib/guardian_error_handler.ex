defmodule BankAccounting.GuardianErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _, _) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:unauthorized, %{"error" => "please authenticate again"} |> Jason.encode!)
  end
end
