defmodule BikeApi.Geo.Point do
  def from_coordinates(lat, lon) do
    %Geo.Point{coordinates: {lat, lon}, srid: 4326}
  end
end
