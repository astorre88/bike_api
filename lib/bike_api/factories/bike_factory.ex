defmodule BikeApi.BikeFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: BikeApi.Repo

  use BikeApi.EventFactory
  use BikeApi.PromoCodeFactory
  use BikeApi.UserFactory
end
