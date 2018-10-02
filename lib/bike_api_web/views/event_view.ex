defmodule BikeApiWeb.EventView do
  use BikeApiWeb, :view
  alias BikeApiWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    case event.place do
      nil ->
        %{
          id: event.id,
          name: event.name,
          radius: event.radius
        }
      _ ->
        {lat, lon} = event.place.coordinates

        %{
          id: event.id,
          name: event.name,
          lat: lat,
          lon: lon,
          radius: event.radius
        }
    end
  end
end
