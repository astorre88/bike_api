defmodule BikeApiWeb.PromoCodeView do
  use BikeApiWeb, :view
  alias BikeApiWeb.PromoCodeView

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code.json")}
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("check.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("check_failed.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "error.json")}
  end

  def render("promo_code.json", %{promo_code: promo_code}) do
    %{
      id: promo_code.id,
      amount: promo_code.amount,
      active: promo_code.active,
      expirates_at: promo_code.expirates_at,
      event_id: promo_code.event_id
    }
  end

  def render("error.json", %{promo_code: promo_code}) do
    %{
      error: "Promo code id=#{promo_code.id} is not valid!"
    }
  end
end
