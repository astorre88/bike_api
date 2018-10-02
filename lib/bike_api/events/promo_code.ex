defmodule BikeApi.Events.PromoCode do
  use Ecto.Schema
  import Ecto.Changeset

  alias BikeApi.Events.Event


  schema "promo_codes" do
    field :active, :boolean, default: false
    field :amount, :integer
    field :expirates_at, :utc_datetime
    belongs_to(:event, Event, foreign_key: :event_id, on_replace: :nilify)

    timestamps()
  end

  @doc false
  def changeset(promo_code, attrs) do
    promo_code
    |> cast(attrs, [:amount, :active, :expirates_at, :event_id])
    |> foreign_key_constraint(:event_id)
    |> validate_required([:amount, :active, :expirates_at, :event_id])
  end
end
