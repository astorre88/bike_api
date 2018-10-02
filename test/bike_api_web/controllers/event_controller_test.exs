defmodule BikeApiWeb.EventControllerTest do
  use BikeApiWeb.ConnCase

  import BikeApi.Guardian
  import BikeApi.BikeFactory

  alias BikeApi.Events.Event

  @create_attrs %{name: "FIFA", lat: 51.512649, lon: -0.133057, radius: 100}
  @update_attrs %{name: "Baseball", lat: 52.512649, lon: -0.133057, radius: 200}
  @invalid_attrs %{name: nil, place: nil}

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
        event: build(:event) |> insert
      ]
    end

    test "lists all events", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(event_path(conn, :index))

      assert json_response(conn, 200)["data"] |> length() == 1
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(event_path(conn, :create), event: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert json_response(conn, 201)["data"] == %{"id" => id, "lat" => 51.512649, "lon" => -0.133057, "name" => "FIFA", "radius" => 100}
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> post(event_path(conn, :create), event: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup do
      [event: build(:event) |> insert]
    end

    test "renders event when data is valid", %{
      conn: conn,
      token: token,
      event: %Event{id: id} = event
    } do
      conn =
        conn
        |> put_req_header("authorization", "bearer: " <> token)
        |> put(event_path(conn, :update, event), event: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]
      assert json_response(conn, 200)["data"] == %{"id" => id, "lat" => 52.512649, "lon" => -0.133057, "name" => "Baseball", "radius" => 200}
    end
  end
end
