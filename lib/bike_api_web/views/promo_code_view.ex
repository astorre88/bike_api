defmodule BikeApiWeb.PromoCodeView do
  use BikeApiWeb, :view
  alias BikeApiWeb.PromoCodeView

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code.json")}
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("promo_code.json", %{promo_code: promo_code}) do
    %{id: promo_code.id,
      amount: promo_code.amount,
      active: promo_code.active}
  end
end
