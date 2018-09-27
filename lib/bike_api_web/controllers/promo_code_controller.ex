defmodule BikeApiWeb.PromoCodeController do
  use BikeApiWeb, :controller

  alias BikeApi.Events
  alias BikeApi.Events.PromoCode

  action_fallback BikeApiWeb.FallbackController

  def index(conn, _params) do
    promo_codes = Events.list_promo_codes()
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def create(conn, %{"promo_code" => promo_code_params}) do
    with {:ok, %PromoCode{} = promo_code} <- Events.create_promo_code(promo_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", promo_code_path(conn, :show, promo_code))
      |> render("show.json", promo_code: promo_code)
    end
  end

  def show(conn, %{"id" => id}) do
    promo_code = Events.get_promo_code!(id)
    render(conn, "show.json", promo_code: promo_code)
  end

  def update(conn, %{"id" => id, "promo_code" => promo_code_params}) do
    promo_code = Events.get_promo_code!(id)

    with {:ok, %PromoCode{} = promo_code} <- Events.update_promo_code(promo_code, promo_code_params) do
      render(conn, "show.json", promo_code: promo_code)
    end
  end
end