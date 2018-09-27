defmodule BikeApi.EventFactory do
  @moduledoc false

  alias BikeApi.Events.Event

  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Event{
          name: "FIFA",
          place: %Geo.Point{coordinates: {51.512649, -0.133057}, srid: 4326},
          radius: 100
        }
      end
    end
  end
end
