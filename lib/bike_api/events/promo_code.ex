defmodule BikeApi.Events.PromoCode do
  use Ecto.Schema
  import Ecto.Changeset

  alias BikeApi.Events.Event


  schema "promo_codes" do
    field :active, :boolean, default: false
    field :amount, :integer
    belongs_to(:event, Event, on_replace: :nilify)

    timestamps()
  end

  @doc false
  def changeset(promo_code, attrs) do
    promo_code
    |> cast(attrs, [:amount, :active])
    |> validate_required([:amount, :active])
  end
end
