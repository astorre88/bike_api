defmodule BikeApiWeb.SessionController do
  use BikeApiWeb, :controller

  alias BikeApi.Accounts
  alias BikeApi.Guardian

  action_fallback BikeApiWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        render(conn, "jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.current_token
    |> Guardian.revoke

    conn
    |> put_status(:no_content)
    |> render("delete.json")
  end
end
