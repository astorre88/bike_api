defmodule BikeApi.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias BikeApi.Geo.Point


  schema "events" do
    field :name, :string
    field :lat, :float, virtual: true
    field :lon, :float, virtual: true
    field :place, Geo.PostGIS.Geometry
    field :radius, :integer
    has_many(:promo_codes, BikeApi.Events.PromoCode)

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :lat, :lon, :radius])
    |> validate_required([:name, :lat, :lon, :radius])
    |> unique_constraint(:name)
    |> put_coordinates
  end

  @doc false
  def update_changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :lat, :lon, :radius])
    |> unique_constraint(:name)
    |> put_coordinates
  end

  defp put_coordinates(%Ecto.Changeset{valid?: true, changes: %{lat: lat, lon: lon}} = changeset) do
    place = Point.from_coordinates(lat, lon)
    put_change(changeset, :place, place)
  end
  defp put_coordinates(changeset) do
    changeset
  end
end
