defmodule BikeApi.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :name, :string
    field :place, Geo.PostGIS.Geometry
    field :radius, :integer

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :place, :radius])
    |> validate_required([:name, :place, :radius])
    |> unique_constraint(:name)
  end
end
