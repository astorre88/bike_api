defmodule BikeApi.EventFactory do
  @moduledoc false

  alias BikeApi.Events.Event
  alias BikeApi.Geo.Point

  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Event{
          name: "FIFA",
          place: Point.from_coordinates(51.512649, -0.133057),
          radius: 100
        }
      end
    end
  end
end
