defmodule BikeApi.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS

  alias BikeApi.Repo
  alias BikeApi.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events(%{})
      [%PromoCode{}, ...]

  """
  def list_events(_params) do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias BikeApi.Events.PromoCode

  @doc """
  Returns the filtered list of promo_codes.

  ## Examples

      iex> list_filtered_promo_codes(%{"active" => true})
      [%PromoCode{}, ...]

  """
  def list_promo_codes(%{"active" => "true"}) do
    Repo.all(
      from p in PromoCode,
      where: p.active == true,
      preload: [:event]
    )
  end
  def list_promo_codes(%{"active" => "false"}) do
    Repo.all(
      from p in PromoCode,
      where: p.active == false,
      preload: [:event]
    )
  end
  def list_promo_codes(_params) do
    Repo.all(
      from p in PromoCode,
      preload: [:event]
    )
  end

  def any_in_location(promo_code, place, radius) do
    Repo.one(
      from e in Event,
      where: e.id == ^promo_code.event_id,
      select: st_dwithin(e.place, ^place, ^radius)
    )
  end

  @doc """
  Gets a single promo_code.

  Raises `Ecto.NoResultsError` if the Promo code does not exist.

  ## Examples

      iex> get_promo_code!(123)
      %PromoCode{}

      iex> get_promo_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promo_code!(id) do
    Repo.one(
      from promo_code in PromoCode,
      where: promo_code.id == ^id,
      preload: [:event]
    )
  end

  @doc """
  Creates a promo_code.

  ## Examples

      iex> create_promo_code(%{field: value})
      {:ok, %PromoCode{}}

      iex> create_promo_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promo_code(attrs \\ %{}) do
    %PromoCode{}
    |> PromoCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promo_code.

  ## Examples

      iex> update_promo_code(promo_code, %{field: new_value})
      {:ok, %PromoCode{}}

      iex> update_promo_code(promo_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promo_code(%PromoCode{} = promo_code, attrs) do
    promo_code
    |> PromoCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promo_code changes.

  ## Examples

      iex> change_promo_code(promo_code)
      %Ecto.Changeset{source: %PromoCode{}}

  """
  def change_promo_code(%PromoCode{} = promo_code) do
    PromoCode.changeset(promo_code, %{})
  end
end
