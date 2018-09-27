defmodule BikeApi.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :amount, :integer
      add :active, :boolean, default: false, null: false
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:promo_codes, [:event_id])
  end
end
