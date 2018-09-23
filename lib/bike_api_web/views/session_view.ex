defmodule BikeApiWeb.SessionView do
  use BikeApiWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
