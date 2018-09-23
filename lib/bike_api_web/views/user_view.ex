defmodule BikeApiWeb.UserView do
  use BikeApiWeb, :view
  alias BikeApiWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email}
  end
end
