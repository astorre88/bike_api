defmodule BikeApiWeb.SessionControllerTest do
  use BikeApiWeb.ConnCase

  import BikeApi.Guardian
  import BikeApi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: insert(:user)}
  end

  describe "sign_out" do
    test "returns 204", %{conn: conn, user: user} do
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put_req_header("authorization", "bearer: " <> token)
        |> delete(session_path(conn, :delete))

      assert json_response(conn, 204) == %{"ok" => true}
    end
  end
end
