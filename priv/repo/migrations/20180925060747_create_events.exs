defmodule BikeApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :radius, :integer

      timestamps()
    end

    create unique_index(:events, [:name])
    execute("SELECT AddGeometryColumn ('events','place',4326,'POINT',2)")
    execute("CREATE INDEX events_place_index on events USING gist (place)")
  end
end
