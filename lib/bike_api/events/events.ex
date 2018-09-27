defmodule BikeApi.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias BikeApi.Repo

  alias BikeApi.Events.Event

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
    |> Event.changeset(attrs)
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
  Returns the list of promo_codes.

  ## Examples

      iex> list_promo_codes()
      [%PromoCode{}, ...]

  """
  def list_promo_codes do
    Repo.all(PromoCode)
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
  def get_promo_code!(id), do: Repo.get!(PromoCode, id)

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
