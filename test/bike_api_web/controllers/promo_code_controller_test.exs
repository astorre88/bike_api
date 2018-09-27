defmodule BikeApiWeb.PromoCodeControllerTest do
  use BikeApiWeb.ConnCase

  import BikeApi.Guardian
  import BikeApi.BikeFactory

  alias BikeApi.Events
  alias BikeApi.Events.PromoCode

  @create_attrs %{active: true, amount: 42}
  @update_attrs %{active: false, amount: 43}
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
    test "lists all promo_codes", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(promo_code_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promo_code" do
    test "renders promo_code when data is valid", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(promo_code_path(conn, :create), promo_code: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert json_response(conn, 201)["data"] == %{"id" => id, "active" => true, "amount" => 42}
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

      assert %{"id" => ^id} = json_response(conn, 200)["data"]
      assert json_response(conn, 200)["data"] == %{"id" => id, "active" => false, "amount" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, token: token, promo_code: promo_code} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> put(promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
