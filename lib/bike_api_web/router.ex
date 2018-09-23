defmodule BikeApiWeb.Router do
  use BikeApiWeb, :router

  alias BikeApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", BikeApiWeb do
    pipe_through :api

    post("/sign_up", RegistrationController, :create)
    post("/sign_in", SessionController, :create)
  end

  scope "/api/v1", BikeApiWeb do
    pipe_through [:api, :jwt_authenticated]

    get("/profile", UserController, :show)
  end
end
