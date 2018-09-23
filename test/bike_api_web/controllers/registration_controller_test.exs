defmodule BikeApiWeb.RegistrationControllerTest do
  use BikeApiWeb.ConnCase

  alias BikeApi.Accounts

  @valid_attrs %{email: "test@email.com", password: "12345678", password_confirmation: "12345678"}
  @invalid_attrs %{email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@valid_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, registration_path(conn, :create), user: @valid_attrs)

      user = Accounts.get_user_by_email("test@email.com")

      assert json_response(conn, 201)["data"] == %{"id" => user.id, "email" => user.email}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, registration_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
