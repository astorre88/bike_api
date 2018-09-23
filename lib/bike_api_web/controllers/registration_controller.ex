defmodule BikeApiWeb.RegistrationController do
  use BikeApiWeb, :controller

  alias BikeApi.Accounts
  alias BikeApi.Accounts.User
  alias BikeApiWeb.UserView

  action_fallback BikeApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(UserView, "show.json", user: user)
    end
  end
end
