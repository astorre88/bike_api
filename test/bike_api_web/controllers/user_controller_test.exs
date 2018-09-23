defmodule BikeApiWeb.UserControllerTest do
  use BikeApiWeb.ConnCase

  import BikeApi.Guardian
  import BikeApi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: insert(:user)}
  end

  describe "unauthenticated profile" do
    test "returns 401", %{conn: conn, user: user} do
      conn = get(conn, user_path(conn, :show))

      assert json_response(conn, 401)
    end
  end

  describe "authenticated profile" do
    test "returns 200", %{conn: conn, user: user} do
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put_req_header("authorization", "bearer: " <> token)
        |> get(user_path(conn, :show))

      assert json_response(conn, 200)["data"] == %{"id" => user.id, "email" => user.email}
    end
  end
end
