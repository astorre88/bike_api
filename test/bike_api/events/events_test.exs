defmodule BikeApi.EventsTest do
  use BikeApi.DataCase

  alias BikeApi.Events

  describe "events" do
    alias BikeApi.Events.Event

    @valid_attrs %{name: "some name", place: %Geo.Point{coordinates: {51.512649, -0.133057}, srid: 4326}, radius: 100}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Events.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "promo_codes" do
    alias BikeApi.Events.PromoCode

    @valid_attrs %{active: true, amount: 42}
    @update_attrs %{active: false, amount: 43}
    @invalid_attrs %{active: nil, amount: nil, event: nil}

    def promo_code_fixture(attrs \\ %{}) do
      {:ok, promo_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_promo_code()

      promo_code
    end

    test "list_promo_codes/0 returns all promo_codes" do
      promo_code = promo_code_fixture()
      assert Events.list_promo_codes() == [promo_code]
    end

    test "get_promo_code!/1 returns the promo_code with given id" do
      promo_code = promo_code_fixture()
      assert Events.get_promo_code!(promo_code.id) == promo_code
    end

    test "create_promo_code/1 with valid data creates a promo_code" do
      assert {:ok, %PromoCode{} = promo_code} = Events.create_promo_code(@valid_attrs)
      assert promo_code.active == true
      assert promo_code.amount == 42
    end

    test "create_promo_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_promo_code(@invalid_attrs)
    end

    test "update_promo_code/2 with valid data updates the promo_code" do
      promo_code = promo_code_fixture()
      assert {:ok, promo_code} = Events.update_promo_code(promo_code, @update_attrs)
      assert %PromoCode{} = promo_code
      assert promo_code.active == false
      assert promo_code.amount == 43
    end

    test "update_promo_code/2 with invalid data returns error changeset" do
      promo_code = promo_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_promo_code(promo_code, @invalid_attrs)
      assert promo_code == Events.get_promo_code!(promo_code.id)
    end

    test "change_promo_code/1 returns a promo_code changeset" do
      promo_code = promo_code_fixture()
      assert %Ecto.Changeset{} = Events.change_promo_code(promo_code)
    end
  end
end
