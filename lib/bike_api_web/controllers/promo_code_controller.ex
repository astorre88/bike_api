defmodule BikeApiWeb.PromoCodeController do
  use BikeApiWeb, :controller

  alias BikeApi.Events
  alias BikeApi.Events.PromoCode
  alias BikeApi.Geo.Point

  action_fallback BikeApiWeb.FallbackController

  def index(conn, params) do
    promo_codes = Events.list_promo_codes(params)
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

  def check(
    conn,
    %{
      "promo_code_id" => id,
      "trip" => %{
        "origin" => %{
          "lat" => origin_lat,
          "lon" => origin_lon
        },
        "destination" => %{
          "lat" => destination_lat,
          "lon" => destination_lon
        }
      }
    }) do
    promo_code = Events.get_promo_code!(id)

    origin = Point.from_coordinates(origin_lat, origin_lon)
    destination = Point.from_coordinates(destination_lat, destination_lon)

    near_trip_promo_code = Events.any_in_location(promo_code, origin, promo_code.event.radius) || Events.any_in_location(promo_code, destination, promo_code.event.radius)

    if near_trip_promo_code do
      render(conn, "check.json", promo_code: promo_code)
    else
      render(conn, "check_failed.json", promo_code: promo_code)
    end
  end
end
