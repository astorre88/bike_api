defmodule BikeApi.AccountsTest do
  use BikeApi.DataCase

  import BikeApi.BikeFactory

  alias BikeApi.Accounts

  describe "users" do
    alias BikeApi.Accounts.User

    @valid_attrs %{email: "test@email.com", password: "12345678", password_confirmation: "12345678"}
    @invalid_attrs %{email: nil, password: nil}

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == %{user | password: nil, password_confirmation: nil}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "test@email.com"
      assert String.length(user.password_hash) > 0
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
