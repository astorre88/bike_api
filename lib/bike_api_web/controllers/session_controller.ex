defmodule BikeApiWeb.SessionController do
  use BikeApiWeb, :controller

  alias BikeApi.Accounts

  action_fallback BikeApiWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        render(conn, "jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
end
