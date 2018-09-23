defmodule BikeApiWeb.UserController do
  use BikeApiWeb, :controller

  alias BikeApi.Guardian

  action_fallback BikeApiWeb.FallbackController

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end
end
