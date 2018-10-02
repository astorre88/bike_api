defmodule BikeApiWeb.PromoCodeControllerTest do
  use BikeApiWeb.ConnCase

  import BikeApi.Guardian
  import BikeApi.BikeFactory

  alias BikeApi.Events.PromoCode

  @old_date Ecto.DateTime.utc
  @expirates_at %{@old_date | day: @old_date.day + 1} |> to_string
  @create_attrs %{amount: 42, expirates_at: @expirates_at, event_id: 1}
  @update_attrs %{active: true, amount: 43, expirates_at: @expirates_at}
  @invalid_attrs %{active: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, token, _} = encode_and_sign(insert(:user), %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")

    {:ok, conn: conn, token: token}
  end

  describe "index" do
    setup do
      [
        active_promo_code: build(:promo_code, active: true) |> with_event(build(:event, name: "Football")) |> insert,
        non_active_promo_code: build(:promo_code, active: false) |> with_event(build(:event, name: "Concert")) |> insert
      ]
    end

    test "lists all promo_codes", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(promo_code_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 2
    end

    test "lists active promo_codes", %{
      conn: conn,
      token: token,
      active_promo_code: %PromoCode{id: active_id} = _active_promo_code
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(promo_code_path(conn, :index), active: "true")

      assert json_response(conn, 200)["data"] |> Enum.map(&(&1["id"])) == [active_id]
    end

    test "lists nonactive promo_codes", %{
      conn: conn,
      token: token,
      non_active_promo_code: %PromoCode{id: non_active_id} = _non_active_promo_code
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(promo_code_path(conn, :index), active: "false")

      assert json_response(conn, 200)["data"] |> Enum.map(&(&1["id"])) == [non_active_id]
    end
  end

  describe "create promo_code" do
    setup do
      [
        event: insert(:event)
      ]
    end

    test "renders promo_code when data is valid", %{conn: conn, token: token, event: event} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(promo_code_path(conn, :create), promo_code: %{@create_attrs | event_id: event.id})

      assert %{"id" => id, "expirates_at" => expirates_at} = json_response(conn, 201)["data"]
      assert json_response(conn, 201)["data"] == %{"id" => id, "active" => false, "amount" => 42, "expirates_at" => expirates_at, "event_id" => event.id}
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(promo_code_path(conn, :create), promo_code: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promo_code" do
    setup do
      [promo_code: build(:promo_code) |> with_event(build(:event)) |> insert]
    end

    test "renders promo_code when data is valid", %{
      conn: conn,
      token: token,
      promo_code: %PromoCode{id: id} = promo_code
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> put(promo_code_path(conn, :update, promo_code), promo_code: @update_attrs)

      assert %{"id" => ^id, "expirates_at" => expirates_at} = json_response(conn, 200)["data"]
      assert json_response(conn, 200)["data"] == %{"id" => id, "active" => true, "amount" => 43, "expirates_at" => expirates_at, "event_id" => promo_code.event_id}
    end

    test "renders errors when data is invalid", %{conn: conn, token: token, promo_code: promo_code} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> put(promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "check promo_code" do
    setup do
      [promo_code: build(:promo_code) |> with_event(build(:event, radius: 2)) |> insert]
    end

    test "renders promo_code when trip source or destination are within the event radius", %{
      conn: conn,
      token: token,
      promo_code: %PromoCode{id: id} = promo_code
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(promo_code_promo_code_path(conn, :check, promo_code), trip: %{origin: %{lat: 51.512649, lon: -0.133057}, destination: %{lat: 53.512649, lon: 1.133057}})

      assert %{"id" => ^id, "expirates_at" => expirates_at} = json_response(conn, 200)["data"]
      assert json_response(conn, 200)["data"] == %{"id" => id, "active" => false, "amount" => 100, "expirates_at" => expirates_at, "event_id" => promo_code.event_id}
    end

    test "renders error when trip source or destination are outside the event radius", %{
      conn: conn,
      token: token,
      promo_code: %PromoCode{id: id} = promo_code
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(promo_code_promo_code_path(conn, :check, promo_code), trip: %{origin: %{lat: 53.612649, lon: -0.133057}, destination: %{lat: 53.512649, lon: 1.133057}})

      assert json_response(conn, 200)["data"] == %{"error" => "Promo code id=#{id} is not valid!"}
    end
  end
end
