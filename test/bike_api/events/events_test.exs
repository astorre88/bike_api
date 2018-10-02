defmodule BikeApi.EventsTest do
  use BikeApi.DataCase

  import BikeApi.BikeFactory

  alias BikeApi.Events

  describe "events" do
    alias BikeApi.Events.Event

    @valid_attrs %{name: "some name", lat: 51.512649, lon: -0.133057, radius: 100}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_events/1 returns all events" do
      event = insert(:event)
      assert Events.list_events(%{}) == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = insert(:event)
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
      event = insert(:event, @update_attrs)
      assert {:ok, event} = Events.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.name == "some updated name"
    end

    test "change_event/1 returns a event changeset" do
      event = insert(:event)
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "promo_codes" do
    alias BikeApi.Events.PromoCode

    @old_date Ecto.DateTime.utc
    @valid_attrs %{active: true, amount: 42, event_id: nil, expirates_at: %{@old_date | day: @old_date.day + 1} |> to_string}
    @update_attrs %{active: false, amount: 43, expirates_at: %{@old_date | day: @old_date.day + 1} |> to_string}
    @invalid_attrs %{active: nil, amount: nil, event: nil}

    setup do
      [
        promo_code: build(:promo_code) |> with_event(build(:event)) |> insert
      ]
    end

    test "list_promo_codes/1 with empty map returns all promo_codes", %{promo_code: promo_code} do
      assert Events.list_promo_codes(%{}) == [promo_code]
    end

    test "list_promo_codes/1 with active: true returns active promo_codes" do
      assert Events.list_promo_codes(%{"active" => "true"}) == []
    end

    test "list_promo_codes/1 with active: false returns non active promo_codes", %{promo_code: promo_code} do
      assert Events.list_promo_codes(%{"active" => "false"}) == [promo_code]
    end

    test "get_promo_code!/1 returns the promo_code with given id", %{promo_code: promo_code} do
      assert Events.get_promo_code!(promo_code.id) == promo_code
    end

    test "create_promo_code/1 with valid data creates a promo_code", %{promo_code: promo_code} do
      assert {:ok, %PromoCode{} = promo_code} = Events.create_promo_code(%{@valid_attrs | event_id: promo_code.event.id})
      assert promo_code.active == true
      assert promo_code.amount == 42
    end

    test "create_promo_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_promo_code(@invalid_attrs)
    end

    test "update_promo_code/2 with valid data updates the promo_code", %{promo_code: promo_code} do
      assert {:ok, promo_code} = Events.update_promo_code(promo_code, @update_attrs)
      assert %PromoCode{} = promo_code
      assert promo_code.active == false
      assert promo_code.amount == 43
    end

    test "update_promo_code/2 with invalid data returns error changeset", %{promo_code: promo_code} do
      assert {:error, %Ecto.Changeset{}} = Events.update_promo_code(promo_code, @invalid_attrs)
      assert promo_code == Events.get_promo_code!(promo_code.id)
    end

    test "change_promo_code/1 returns a promo_code changeset", %{promo_code: promo_code} do
      assert %Ecto.Changeset{} = Events.change_promo_code(promo_code)
    end
  end
end
